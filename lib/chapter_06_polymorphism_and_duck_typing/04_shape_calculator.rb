# frozen_string_literal: true

# Implement the shape classes and ShapeCalculator here
#
# This exercise demonstrates polymorphism with geometric shapes.
# All shapes share: area, perimeter, and shape_type methods.
#
# Circle class:
# - initialize(radius)
# - radius reader
# - area returns Math::PI * radius^2
# - perimeter returns 2 * Math::PI * radius
# - shape_type returns "circle"
#
# Rectangle class:
# - initialize(width, height)
# - width, height readers
# - area returns width * height
# - perimeter returns 2 * (width + height)
# - shape_type returns "rectangle"
#
# Triangle class:
# - initialize(base, height, side_a, side_b, side_c)
# - base, height readers
# - area returns 0.5 * base * height
# - perimeter returns side_a + side_b + side_c
# - shape_type returns "triangle"
#
# ShapeCalculator class:
# - total_area(shapes) returns sum of all shapes' areas
# - total_perimeter(shapes) returns sum of all shapes' perimeters
# - largest_shape(shapes) returns shape with largest area (nil if empty)
# - shapes_report(shapes) returns array of strings:
#   "#{shape_type}: area = #{area}, perimeter = #{perimeter}"
#   Round area to 2 decimal places for display
