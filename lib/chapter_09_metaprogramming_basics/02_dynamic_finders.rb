# frozen_string_literal: true

# Chapter 09: Metaprogramming Basics
# Exercise 02: Dynamic Finders
#
# ActiveRecord popularized dynamic finder methods like find_by_email or
# find_by_name. These methods don't exist until you call them - Ruby intercepts
# the missing method call and generates the behavior on the fly.
#
# Implement the following:
#
# 1. DynamicFinders module
#    - method_missing(method_name, *args) - intercept calls matching find_by_*
#      - Parse the attribute name from the method (find_by_email -> :email)
#      - Search through @records for a hash where that key matches the argument
#      - Return the first matching record or nil
#      - Raise NoMethodError for methods not matching find_by_* pattern
#    - respond_to_missing?(method_name, include_private = false)
#      - Return true if method_name matches find_by_* pattern
#      - This ensures respond_to? works correctly with dynamic methods
#
# 2. UserRepository class
#    - Include DynamicFinders
#    - initialize(records) - stores an array of hashes in @records
#    - Support find_by_name(value), find_by_email(value), etc. dynamically

module Chapter09
  ##
  # Module providing dynamic finder methods via method_missing
  module DynamicFinders
    # TODO: Implement method_missing to handle find_by_* calls
    # Hint: Use method_name.to_s.start_with?('find_by_') to check pattern
    # Hint: Extract attribute with method_name.to_s.sub('find_by_', '').to_sym

    # TODO: Implement respond_to_missing? for find_by_* methods
    # This is important for proper Ruby behavior (e.g., respond_to? returns true)
  end

  ##
  # Repository for finding users by any attribute dynamically
  class UserRepository
    # TODO: Include DynamicFinders and implement initialize(records)
  end
end
