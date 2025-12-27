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

class Shape
end

class Circle < Shape
end

class Square < Shape
end
