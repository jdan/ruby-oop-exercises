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
end

# BuyOneGetOneFree class:
# - name - returns "Buy One Get One Free"
# - apply(price) - returns price * 0.5
# - description - returns "Buy one, get one free"

##
# Effectively 50% off
class BuyOneGetOneFree
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
end

# PriceCalculator class:
# - initialize(discount) - accepts any object with #apply method
# - discount reader
# - calculate(original_price) - delegates to discount.apply
# - calculate_with_month(original_price, month) - for seasonal discounts

##
# Calculates final price using any discount type (duck typing)
class PriceCalculator
end
