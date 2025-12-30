# frozen_string_literal: true

# Chapter 08: Design Patterns
# Exercise 04: Decorator Pattern
#
# The Decorator Pattern attaches additional responsibilities to objects
# dynamically. Decorators provide a flexible alternative to subclassing.
#
# Implement a coffee shop beverage system:
#
# 1. Coffee class (base beverage)
#    - cost - returns 2.00
#    - description - returns "Coffee"
#
# 2. Espresso class (another base beverage)
#    - cost - returns 3.00
#    - description - returns "Espresso"
#
# 3. MilkDecorator class
#    - initialize(beverage) - wraps a beverage
#    - cost - adds 0.50 to wrapped beverage cost
#    - description - adds "with Milk" to description
#
# 4. SugarDecorator class
#    - initialize(beverage) - wraps a beverage
#    - cost - adds 0.25 to wrapped beverage cost
#    - description - adds "with Sugar" to description
#
# 5. WhipDecorator class
#    - initialize(beverage) - wraps a beverage
#    - cost - adds 0.75 to wrapped beverage cost
#    - description - adds "with Whipped Cream" to description
#
# Decorators should be stackable (you can wrap a decorator in another decorator)

module Chapter08
  ##
  # Base coffee beverage
  class Coffee
    # TODO: Implement Coffee
  end

  ##
  # Espresso beverage
  class Espresso
    # TODO: Implement Espresso
  end

  ##
  # Base decorator that wraps a beverage (optional - you can also implement
  # each decorator independently)
  class BeverageDecorator
    # TODO: Implement base decorator (optional)
  end

  ##
  # Adds milk to a beverage
  class MilkDecorator
    # TODO: Implement MilkDecorator
  end

  ##
  # Adds sugar to a beverage
  class SugarDecorator
    # TODO: Implement SugarDecorator
  end

  ##
  # Adds whipped cream to a beverage
  class WhipDecorator
    # TODO: Implement WhipDecorator
  end
end
