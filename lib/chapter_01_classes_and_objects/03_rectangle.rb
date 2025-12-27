# frozen_string_literal: true

# Implement the Rectangle class here
#
# A Rectangle should:
# - Be initialized with width and height
# - Have an area method that returns width * height
# - Have a perimeter method that returns 2 * (width + height)
# - Have a square? method that returns true if width equals height

##
# A rectangle class which can compute its area and perimeter.
class Rectangle
  def initialize(width, height)
    @width = width
    @height = height
  end

  def area
    @width * @height
  end

  def perimeter
    (2 * @width) + (2 * @height)
  end

  def square?
    @width == @height
  end
end
