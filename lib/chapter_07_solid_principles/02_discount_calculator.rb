# frozen_string_literal: true

# Open/Closed Principle (OCP)
#
# Software entities should be open for extension but closed for modification.
# New discount types can be added by creating new classes, not by modifying
# existing code. The PriceCalculator works with any object that responds to #apply.

# PercentageDiscount class:
# - initialize(percent)
# - percent reader
# - name - returns "Percentage Discount (X%)"
# - apply(price) - returns price reduced by percentage
# - description - returns "X% off"

##
# Applies a percentage discount
class PercentageDiscount
  attr_reader :percent

  def initialize(percent)
    @percent = percent
  end

  def name = "Percentage Discount (#{percent}%)"
  def description = "#{percent}% off"

  def apply(price)
    price * (1 - (percent / 100.0))
  end
end

# FlatDiscount class:
# - initialize(amount)
# - amount reader
# - name - returns "Flat Discount ($X)"
# - apply(price) - returns price minus amount (minimum 0)
# - description - returns "$X off"

##
# Applies a fixed amount discount
class FlatDiscount
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end

  def name = "Flat Discount ($#{amount})"
  def description = "$#{amount} off"

  def apply(price)
    return 0 if amount > price

    price - amount
  end
end

# BuyOneGetOneFree class:
# - name - returns "Buy One Get One Free"
# - apply(price) - returns price * 0.5
# - description - returns "Buy one, get one free"

##
# Effectively 50% off
class BuyOneGetOneFree
  def name = 'Buy One Get One Free'
  def description = 'Buy one, get one free'

  def apply(price)
    price * 0.5
  end
end

# SeasonalDiscount class:
# - initialize(percent, valid_months)
# - percent, valid_months readers
# - name - returns "Seasonal Discount"
# - applicable?(current_month) - returns true if month in valid_months
# - apply(price, current_month:) - applies discount only if applicable

##
# Applies discount only during certain months
class SeasonalDiscount
  attr_reader :percent, :valid_months

  def initialize(percent, valid_months)
    @percent = percent
    @valid_months = valid_months
  end

  def name = 'Seasonal Discount'

  def applicable?(current_month)
    valid_months.include? current_month
  end

  def apply(price, current_month:)
    return price unless applicable?(current_month)

    # Composition
    PercentageDiscount.new(percent).apply(price)
  end
end

# PriceCalculator class:
# - initialize(discount) - accepts any object with #apply method
# - discount reader
# - calculate(original_price) - delegates to discount.apply
# - calculate_with_month(original_price, month) - for seasonal discounts

##
# Calculates final price using any discount type (duck typing)
class PriceCalculator
  attr_reader :discount

  def initialize(discount)
    @discount = discount
  end

  def calculate(original_price)
    @discount.apply(original_price)
  end

  def calculate_with_month(original_price, month)
    @discount.apply(original_price, current_month: month)
  end
end
