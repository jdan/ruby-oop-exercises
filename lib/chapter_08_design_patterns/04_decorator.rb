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
  Coffee = Struct.new do
    def cost = 2.00
    def description = 'Coffee'
  end

  ##
  # Espresso beverage
  Espresso = Struct.new do
    def cost = 3.00
    def description = 'Espresso'
  end

  ##
  # Base decorator that wraps a beverage (optional - you can also implement
  # each decorator independently)
  class BaseDecorator
    def initialize(beverage, additional_cost, additional_description)
      @beverage = beverage
      @additional_cost = additional_cost
      @additional_description = additional_description
    end

    def cost
      @beverage.cost + @additional_cost
    end

    def description
      "#{@beverage.description}#{@additional_description}"
    end
  end

  ##
  # Adds milk to a beverage
  class MilkDecorator < BaseDecorator
    def initialize(beverage)
      super(beverage, 0.50, ' with Milk')
    end
  end

  ##
  # Adds sugar to a beverage
  class SugarDecorator < BaseDecorator
    def initialize(beverage)
      super(beverage, 0.25, ' with Sugar')
    end
  end

  ##
  # Adds whipped cream to a beverage
  class WhipDecorator < BaseDecorator
    def initialize(beverage)
      super(beverage, 0.75, ' with Whipped Cream')
    end
  end
end
