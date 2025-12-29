# frozen_string_literal: true

# Implement the Shape class hierarchy here
#
# Shape (base class):
# - area method (raises NotImplementedError)
# - perimeter method (raises NotImplementedError)
#
# Circle (inherits from Shape):
# - initialize(radius)
# - area returns PI * radius^2
# - perimeter returns 2 * PI * radius
# - Use Math::PI for pi
#
# Square (inherits from Shape):
# - initialize(side)
# - area returns side^2
# - perimeter returns 4 * side

module Chapter03
  ##
  # A shape is a base class for geometric objects
  class Shape
    def area
      raise NotImplementedError
    end

    def perimeter
      raise NotImplementedError
    end
  end

  ##
  # A circle is a shape with a radius
  class Circle < Shape
    def initialize(radius)
      super()
      @radius = radius
    end

    def perimeter
      2 * Math::PI * @radius
    end

    def area
      Math::PI * (@radius**2)
    end
  end

  ##
  # A square is a shape with a side length
  class Square < Shape
    def initialize(side_length)
      super()
      @side_length = side_length
    end

    def perimeter
      4 * @side_length
    end

    def area
      @side_length**2
    end
  end
end
