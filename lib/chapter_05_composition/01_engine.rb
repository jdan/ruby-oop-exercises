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

##
# An engine with horsepower
class Engine
  attr_reader :horsepower

  def initialize(horsepower)
    @horsepower = horsepower
    @running = false
  end

  def running?
    @running
  end

  def start
    @running = true
  end

  def stop
    @running = false
  end
end

# Car class:
# - initialize(model, engine)
# - model reader
# - engine reader
# - start method (delegates to engine)
# - stop method (delegates to engine)
# - running? method (delegates to engine)
# - specs method (returns "#{model} with #{horsepower}hp engine")

##
# A car with an engine
class Car
  attr_reader :model, :engine

  def initialize(model, engine)
    @model = model
    @engine = engine
  end

  def start
    @engine.start
  end

  def stop
    @engine.stop
  end

  def running?
    @engine.running?
  end

  def specs
    "#{model} with #{engine.horsepower}hp engine"
  end
end
