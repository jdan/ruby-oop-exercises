# frozen_string_literal: true

# Implement the Serializable module and the User, Product classes here
#
# The Serializable module should:
# - Define `to_hash` that returns a hash of all serializable attributes
# - Define `to_json` that returns a JSON string representation
# - Define a class method `serializable_attributes(*attrs)` that specifies
#   which attributes should be included in serialization
# - Use `self.class.serializable_attrs` to access the attribute list
#
# When included, the module should use `extend ClassMethods` pattern to add
# the `serializable_attributes` class method.
#
# The User class should:
# - Include the Serializable module
# - Accept name and email in the constructor
# - Have `name` and `email` reader methods
# - Mark name and email as serializable attributes
#
# The Product class should:
# - Include the Serializable module
# - Accept name and price in the constructor
# - Have `name` and `price` reader methods
# - Mark name and price as serializable attributes

require 'json'

##
# A module that provides serialization functionality
module Serializable
  ##
  # Class methods added when Serializable is included
  module ClassMethods
  end
end

##
# A user that can be serialized
class User
end

##
# A product that can be serialized
class Product
end
