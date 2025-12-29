# frozen_string_literal: true

# Implement the speaker classes and make_them_speak function here
#
# This exercise demonstrates duck typing: "If it walks like a duck
# and quacks like a duck, it must be a duck."
# We don't care about class hierarchy - just whether objects respond to #speak.
#
# Dog class:
# - initialize(name)
# - name reader
# - speak method returns "Woof!"
Dog = Struct.new(:name) do
  def speak = 'Woof!'
end

#
# Cat class:
# - initialize(name)
# - name reader
# - speak method returns "Meow!"
Cat = Struct.new(:name) do
  def speak = 'Meow!'
end

#
# Robot class:
# - initialize(name)
# - name reader
# - speak method returns "Beep boop!"
Robot = Struct.new(:name) do
  def speak = 'Beep boop!'
end

#
# SilentObject class:
# - initialize(name)
# - name reader
# - does NOT have a speak method
SilentObject = Struct.new(:name)

#
# make_them_speak(objects) function:
# - Takes an array of objects
# - For each object that responds to :speak, collect "#{name} says: #{speak}"
# - Skip objects that don't respond to :speak
# - Return array of strings
# - Hint: use respond_to?(:speak) to check if object can speak
def make_them_speak(objects)
  objects
    .filter { |o| o.respond_to?(:speak) }
    .map { |speaker| "#{speaker.name} says: #{speaker.speak}" }
end
