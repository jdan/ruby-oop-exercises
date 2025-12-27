# frozen_string_literal: true

# Implement the Animal class hierarchy here
#
# Animal (base class):
# - initialize(name)
# - speak method that returns "Some sound"
# - name reader
#
# Wolf (inherits from Animal):
# - speak method returns "Howl!"
#
# Tiger (inherits from Animal):
# - speak method returns "Roar!"

##
# An animal which can speak nonsense
class Animal
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def speak
    'Some sound'
  end
end

##
# A howling wolf
class Wolf < Animal
  def speak
    'Howl!'
  end
end

##
# A roaring tiger
class Tiger < Animal
  def speak
    'Roar!'
  end
end
