# frozen_string_literal: true

# Implement the ShoppingCart class here
#
# A ShoppingCart should:
# - Be initialized empty
# - Have add_item(name, price) to add items
# - Have remove_item(name) to remove items
# - Have total method that returns the sum of all item prices
# - Have item_count method that returns number of items
# - Items should NOT be directly accessible from outside
# - Have a apply_discount(percent) method that reduces total (use private helper)

##
# A shopping cart which keeps track of its items and discount
class ShoppingCart
  def initialize
    @items = []
    @discount = 0
  end

  def item_count
    @items.count
  end

  def add_item(name, price)
    @items << [name, price]
  end

  def remove_item(name)
    @items.reject! { |item| item[0] == name }
  end

  def total
    @items.sum { |item| item[1] } * (1 - (@discount / 100.0))
  end

  def apply_discount(percent)
    @discount = percent
  end
end
