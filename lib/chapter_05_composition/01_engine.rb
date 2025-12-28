# frozen_string_literal: true

# Implement the Engine and Car classes here
#
# This exercise demonstrates basic composition: a Car "has-a" Engine.
# Instead of inheriting behavior, Car delegates to its Engine component.
#
# Engine class:
# - initialize(horsepower)
# - horsepower reader
# - running? method (returns true/false)
# - start method (sets running to true)
# - stop method (sets running to false)

# Car class:
# - initialize(model, engine)
# - model reader
# - engine reader
# - start method (delegates to engine)
# - stop method (delegates to engine)
# - running? method (delegates to engine)
# - specs method (returns "#{model} with #{horsepower}hp engine")
