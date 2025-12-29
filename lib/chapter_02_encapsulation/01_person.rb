# frozen_string_literal: true

# Implement the Person class here
#
# A Person should:
# - Be initialized with a name, age, and email
# - Have name and age that can be read and written (attr_accessor)
# - Have email that can only be read after initialization (attr_reader)

module Chapter02
  ##
  # A person with mutable name and age, and immutable email
  class Person
    attr_accessor :name, :age
    attr_reader :email

    def initialize(name, age, email)
      @name = name
      @age = age
      @email = email
    end
  end
end
