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
#
# Cat class:
# - initialize(name)
# - name reader
# - speak method returns "Meow!"
#
# Robot class:
# - initialize(name)
# - name reader
# - speak method returns "Beep boop!"
#
# SilentObject class:
# - initialize(name)
# - name reader
# - does NOT have a speak method
#
# make_them_speak(objects) function:
# - Takes an array of objects
# - For each object that responds to :speak, collect "#{name} says: #{speak}"
# - Skip objects that don't respond to :speak
# - Return array of strings
# - Hint: use respond_to?(:speak) to check if object can speak
