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
  def to_hash
    self.class.serializable_attrs.to_h { |sym| [sym, send(sym)] }
  end

  def to_json(*_args)
    to_hash.to_json
  end
end

##
# A user that can be serialized
class User
  include Serializable

  attr_reader :name, :email

  def initialize(name, email)
    @name = name
    @email = email
  end

  def self.serializable_attrs
    %i[name email]
  end
end

##
# A product that can be serialized
class Product
  include Serializable

  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def self.serializable_attrs
    %i[name price]
  end
end
