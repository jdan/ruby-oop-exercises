# frozen_string_literal: true

# Chapter 08: Design Patterns
# Exercise 01: Factory Pattern
#
# The Factory Pattern provides an interface for creating objects without
# specifying their exact classes. This decouples object creation from usage.
#
# Implement the following:
#
# 1. Circle class
#    - initialize(radius) - stores the radius
#    - radius - returns the radius
#    - name - returns "Circle"
#    - area - returns PI * radius^2
#
# 2. Square class
#    - initialize(side) - stores the side length
#    - side - returns the side length
#    - name - returns "Square"
#    - area - returns side^2
#
# 3. Triangle class
#    - initialize(base, height) - stores base and height
#    - base - returns the base
#    - height - returns the height
#    - name - returns "Triangle"
#    - area - returns 0.5 * base * height
#
# 4. ShapeFactory class
#    - self.create(type, **options) - creates the appropriate shape
#      - :circle requires radius:
#      - :square requires side:
#      - :triangle requires base: and height:
#      - raises ArgumentError for unknown types

module Chapter08
  ##
  # A circle shape with a radius
  class Circle
    # TODO: Implement Circle
  end

  ##
  # A square shape with a side length
  class Square
    # TODO: Implement Square
  end

  ##
  # A triangle shape with base and height
  class Triangle
    # TODO: Implement Triangle
  end

  ##
  # Factory for creating shapes without knowing their concrete classes
  class ShapeFactory
    # TODO: Implement ShapeFactory.create(type, **options)
  end
end
