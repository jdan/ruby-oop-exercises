# frozen_string_literal: true

# Implement the MathUtils module and Calculator class here
#
# The MathUtils module should:
# - Be a namespace containing mathematical utility methods
# - Define `MathUtils.square(n)` that returns n * n
# - Define `MathUtils.cube(n)` that returns n * n * n
# - Define `MathUtils.factorial(n)` that returns n! (factorial)
#   - factorial(0) and factorial(1) should return 1
#
# The Calculator class should:
# - Extend MathUtils to gain class-level access to the math methods
# - Have a class method `power_summary(n)` that returns a hash:
#   { square: n², cube: n³ }

module Chapter04
  ##
  # A module providing mathematical utilities
  module MathUtils
    # NOTE: This makes the methods below callable at the module level
    # such as MathUtils.square

    module_function

    def square(num)
      num * num
    end

    def cube(num)
      num * num * num
    end

    def factorial(num)
      return 1 if num.zero?

      (1..num).inject :*
    end
  end

  ##
  # A calculator that uses MathUtils
  class Calculator
    extend MathUtils

    def self.power_summary(num)
      { square: square(num), cube: cube(num) }
    end
  end
end
