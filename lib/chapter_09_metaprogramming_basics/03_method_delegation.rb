# frozen_string_literal: true

# Chapter 09: Metaprogramming Basics
# Exercise 03: Method Delegation
#
# Ruby's Forwardable module and Rails' delegate method let you easily forward
# method calls to another object. This exercise builds a similar delegation
# system using define_method and send.
#
# Implement the following:
#
# 1. Delegatable module
#    - When included, add a delegate class method to the including class
#    - delegate(*methods, to:, prefix: false)
#      - For each method name, create an instance method that calls the same
#        method on the object returned by the `to` target
#      - If prefix: true, prepend the target name to the method
#        (e.g., delegate :name, to: :author, prefix: true creates author_name)
#    - Use define_method and public_send for the delegation
#
# 2. Author class
#    - initialize(name) - stores the name
#    - name - returns the author's name
#
# 3. Book class
#    - Include Delegatable
#    - initialize(title, author) - stores title and author
#    - title - returns the book title
#    - author - returns the author object
#    - Use delegate :name, to: :author, prefix: true to create author_name

module Chapter09
  ##
  # Module providing a delegate class method for easy method forwarding
  module Delegatable
    def self.included(base)
      base.extend(ClassMethods)
    end

    ##
    # Helper module which defines the delegation logic
    module ClassMethods
      #   TODO: Implement delegate(*methods, to:, prefix: false)
      #   Hint: Use define_method to create forwarding methods
      #   Hint: Use public_send(method_name) to call the method on target
      def delegate(*methods, to:, prefix: false)
        methods.each do |method|
          method_name = if prefix
                          "#{to}_#{method}"
                        else
                          method.to_s
                        end

          define_method(method_name) do
            # NOTE: TWO public sends (to grab .author, then .name)
            public_send(to).public_send(method)
          end
        end
      end
    end
  end

  ##
  # Simple author class with a name
  class Author
    attr_accessor :name

    def initialize(name)
      @name = name
    end
  end

  ##
  # Book class that delegates author_name to its author
  class Book
    # TODO: Include Delegatable
    # TODO: Implement initialize(title, author), title, and author readers
    # TODO: Use delegate :name, to: :author, prefix: true
    include Delegatable

    delegate :name, to: :author, prefix: true

    attr_accessor :title, :author

    def initialize(title, author)
      @title = title
      @author = author
    end
  end
end
