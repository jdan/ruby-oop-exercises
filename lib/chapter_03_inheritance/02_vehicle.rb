# frozen_string_literal: true

# Implement the Vehicle class hierarchy here
#
# Vehicle (base class):
# - initialize(make, model, year)
# - info method returns "{year} {make} {model}"
# - readers for make, model, year
#
# Car (inherits from Vehicle):
# - initialize(make, model, year, num_doors)
# - calls super for base attributes
# - num_doors reader
#
# Motorcycle (inherits from Vehicle):
# - initialize(make, model, year, has_sidecar)
# - calls super for base attributes
# - has_sidecar? method

##
# A vehicle with a make and model
class Vehicle
  attr_reader :make, :model, :year

  def initialize(make, model, year)
    @make = make
    @model = model
    @year = year
  end

  def info
    "#{year} #{make} #{model}"
  end
end

##
# A car is a vehicle with doors
class Car < Vehicle
  attr_reader :num_doors

  def initialize(make, model, year, num_doors)
    super(make, model, year)
    @num_doors = num_doors
  end
end

##
# A motorcycle is a vehicle with an optional sidecar
class Motorcycle < Vehicle
  def initialize(make, model, year, has_sidecar)
    super(make, model, year)
    @has_sidecar = has_sidecar
  end

  def has_sidecar?
    @has_sidecar
  end
end
