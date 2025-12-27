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

class Vehicle
end

class Car < Vehicle
end

class Motorcycle < Vehicle
end
