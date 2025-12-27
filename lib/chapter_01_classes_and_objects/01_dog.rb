# frozen_string_literal: true

# Implement the Dog class here
#
# A Dog should:
# - Be initialized with a name and breed
# - Have a bark method that returns "Woof!"
# - Have a describe method that returns "{name} is a {breed}"

##
# A Dog which can bark and describe itself
class Dog
  def initialize(name, breed)
    @name = name
    @breed = breed
  end

  def bark
    'Woof!'
  end

  def describe
    "#{@name} is a #{@breed}"
  end
end
