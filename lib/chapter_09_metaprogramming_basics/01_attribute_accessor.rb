# frozen_string_literal: true

# Chapter 09: Metaprogramming Basics
# Exercise 01: Custom Attribute Accessor
#
# Ruby's attr_accessor is a class macro that dynamically creates getter and
# setter methods. In this exercise, you'll build your own version to understand
# how it works under the hood using define_method.
#
# Implement the following:
#
# 1. AttributeAccessor module
#    - my_attr_accessor(*names) - class method that creates getter and setter
#      methods for each name passed in
#    - Use define_method to create the methods dynamically
#    - Use instance_variable_get and instance_variable_set to access the
#      underlying instance variables
#
# 2. Person class
#    - Extend the AttributeAccessor module
#    - Use my_attr_accessor :name, :age to define attributes
#    - Should work identically to using standard attr_accessor

module Chapter09
  ##
  # Module that provides custom attribute accessor functionality
  # Extend this module to get the my_attr_accessor class method
  module AttributeAccessor
    # TODO: Implement my_attr_accessor(*names)
    # Hint: Use define_method to create getter and setter methods
    # Hint: Use instance_variable_get/set with "@#{name}" for storage
  end

  ##
  # A simple person class using our custom attribute accessor
  class Person
    # TODO: Extend AttributeAccessor and use my_attr_accessor :name, :age
  end
end
