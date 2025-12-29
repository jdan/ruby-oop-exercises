# frozen_string_literal: true

# Implement the shape classes and ShapeCalculator here
#
# This exercise demonstrates polymorphism with geometric shapes.
# All shapes share: area, perimeter, and shape_type methods.

module Chapter06
  Circle = Struct.new(:radius) do
    def area
      Math::PI * (radius**2)
    end

    def perimeter
      2 * Math::PI * radius
    end

    def shape_type = 'circle'
  end

  #
  # Rectangle class:
  # - initialize(width, height)
  # - width, height readers
  # - area returns width * height
  # - perimeter returns 2 * (width + height)
  # - shape_type returns "rectangle"

  Rectangle = Struct.new(:width, :height) do
    def area
      width * height
    end

    def perimeter
      2 * (width + height)
    end

    def shape_type = 'rectangle'
  end

  ##
  # Triangle class:
  # - initialize(base, height, side_a, side_b, side_c)
  # - base, height readers
  # - area returns 0.5 * base * height
  # - perimeter returns side_a + side_b + side_c
  # - shape_type returns "triangle"
  class Triangle
    attr_reader :base, :height

    def initialize(base, height, side_a, side_b, side_c)
      @base = base
      @height = height
      @side_a = side_a
      @side_b = side_b
      @side_c = side_c
    end

    def area
      0.5 * base * height
    end

    def perimeter
      @side_a + @side_b + @side_c
    end

    def shape_type = 'triangle'
  end

  #
  # ShapeCalculator class:
  # - total_area(shapes) returns sum of all shapes' areas
  # - total_perimeter(shapes) returns sum of all shapes' perimeters
  # - largest_shape(shapes) returns shape with largest area (nil if empty)
  # - shapes_report(shapes) returns array of strings:
  #   "#{shape_type}: area = #{area}, perimeter = #{perimeter}"
  #   Round area to 2 decimal places for display
  class ShapeCalculator
    def total_area(shapes)
      shapes.sum(&:area)
    end

    def total_perimeter(shapes)
      shapes.sum(&:perimeter)
    end

    def largest_shape(shapes)
      shapes.max_by(&:area)
    end

    def shapes_report(shapes)
      shapes.map do |shape|
        "#{shape.shape_type}: area = #{shape.area.round(2)}, perimeter = #{shape.perimeter.round(2)}"
      end
    end
  end
end
