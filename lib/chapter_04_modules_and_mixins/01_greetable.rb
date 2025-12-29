# frozen_string_literal: true

# Implement the Greetable module and the Person class here
#
# The Greetable module should:
# - Define a `greet` method that returns "Hello, I'm #{name}!"
# - Be usable by any class that has a `name` method
#
# The Person class should:
# - Include the Greetable module
# - Accept a name in the constructor
# - Have a `name` reader method

module Chapter04
  ##
  # A module that provides greeting functionality
  module Greetable
    def greet
      # NOTE: Delegates to the #name method
      "Hello, I'm #{name}!"
    end
  end

  ##
  # A person who can greet others
  class Person
    include Greetable

    attr_reader :name

    def initialize(name)
      @name = name
    end
  end
end
