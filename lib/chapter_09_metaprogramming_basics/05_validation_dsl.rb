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
    # TODO: Use self.included(base) to set up the including class
    # Hint: Initialize @validations = [] on the class
    # Hint: Use base.extend(ClassMethods)

    # module ClassMethods
    #   TODO: Implement validates_presence_of(*attrs)
    #   TODO: Implement validates_length_of(attr, minimum:, maximum:)
    #   TODO: Implement validates_numericality_of(attr, greater_than: nil)
    #   Hint: Store validation procs/lambdas in @validations
    # end

    # TODO: Implement valid? instance method
    # Hint: Clear errors, run each validation, return errors.empty?

    # TODO: Implement errors instance method
    # Hint: Return @errors hash, default to empty hash
  end

  ##
  # Product with name and price validations
  class Product
    # TODO: Include Validatable
    # TODO: Implement initialize(name, price)
    # TODO: Add attr_accessor :name, :price
    # TODO: validates_presence_of :name
    # TODO: validates_length_of :name, minimum: 2, maximum: 50
    # TODO: validates_numericality_of :price, greater_than: 0
  end

  ##
  # Order with customer_name and total validations
  class Order
    # TODO: Include Validatable
    # TODO: Implement initialize(customer_name, total)
    # TODO: Add attr_accessor :customer_name, :total
    # TODO: validates_presence_of :customer_name
    # TODO: validates_numericality_of :total
  end
end
