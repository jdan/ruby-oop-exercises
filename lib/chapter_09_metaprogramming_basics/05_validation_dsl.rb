# frozen_string_literal: true

# Chapter 09: Metaprogramming Basics
# Exercise 05: Validation DSL
#
# ActiveModel validations provide a clean DSL for declaring validation rules.
# This exercise builds a simplified validation framework combining multiple
# metaprogramming techniques.
#
# Implement the following:
#
# 1. Validatable module
#    - When included, add validation class methods and instance methods
#    - Class methods:
#      - validates_presence_of(*attrs) - attribute must not be nil or empty
#      - validates_length_of(attr, minimum:, maximum:) - string length bounds
#      - validates_numericality_of(attr, greater_than: nil) - must be numeric
#    - Instance methods:
#      - valid? - runs all validations, returns true/false
#      - errors - returns hash of { attribute: [error_messages] }
#    - Store validations at the class level (use class instance variables)
#    - Each subclass should have its own validations (use inherited hook)
#
# 2. Product class
#    - Include Validatable
#    - initialize(name, price)
#    - attr_accessor :name, :price
#    - Validations:
#      - name: presence, length 2..50
#      - price: numericality, greater_than 0
#
# 3. Order class
#    - Include Validatable
#    - initialize(customer_name, total)
#    - attr_accessor :customer_name, :total
#    - Validations:
#      - customer_name: presence
#      - total: numericality

module Chapter09
  ##
  # Module providing ActiveModel-style validations
  module Validatable
    def self.included(base)
      base.extend(ClassMethods)
    end

    ##
    # Utility methods for defining validators
    module ClassMethods
      # NOTE: @validations here is a "class instance variable" - it belongs to
      # the class object itself (e.g., Product), not instances of that class.
      # - @@validations (class variable) = shared across ALL classes in hierarchy (bad here)
      # - @validations in ClassMethods = belongs to Product/Order class objects (good, per-class)
      # - @validations in instance methods = belongs to each Product.new instance
      def validations
        @validations ||= []
      end

      def validates_presence_of(*attrs)
        attrs.each do |attr|
          validations << proc {
            value = public_send(attr)
            @errors[attr] << "can't be blank" if value.nil? || (value.respond_to?(:empty?) && value.empty?)
          }
        end
      end

      def validates_length_of(attr, minimum:, maximum:)
        validations << proc {
          value = public_send(attr)
          if value && value.respond_to?(:length)
            len = value.length
            @errors[attr] << 'is too short' if len < minimum
            @errors[attr] << 'is too long' if len > maximum
          end
        }
      end

      def validates_numericality_of(attr, greater_than: nil)
        validations << proc {
          value = public_send(attr)
          if !value.is_a?(Numeric)
            @errors[attr] << 'is not a number'
          elsif greater_than && value <= greater_than
            @errors[attr] << "must be greater than #{greater_than}"
          end
        }
      end
    end

    # NOTE: This is an instance method, so `self` is e.g. Product.new("Widget", 9.99).
    # We need `self.class` to get Product, then `.validations` to access the
    # class instance variable where validators are stored.
    # instance_exec runs each proc with `self` set to this instance, so the
    # proc can call public_send(:name) and access @errors on this instance.
    def valid?
      @errors = Hash.new { |h, k| h[k] = [] }
      self.class.validations.each { |v| instance_exec(&v) }
      @errors.empty?
    end

    def errors
      @errors || {}
    end
  end

  ##
  # Product with name and price validations
  class Product
    include Validatable

    attr_accessor :name, :price

    validates_presence_of :name
    validates_length_of :name, minimum: 2, maximum: 50
    validates_numericality_of :price, greater_than: 0

    def initialize(name, price)
      @name = name
      @price = price
    end
  end

  ##
  # Order with customer_name and total validations
  class Order
    include Validatable

    attr_accessor :customer_name, :total

    validates_presence_of :customer_name
    validates_numericality_of :total

    def initialize(customer_name, total)
      @customer_name = customer_name
      @total = total
    end
  end
end
