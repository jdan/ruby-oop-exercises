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

module Chapter02
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
      @items << Item.new(name, price)
    end

    def remove_item(name)
      @items.reject! { |item| item.is? name }
    end

    def total
      mult = 1 - (@discount / 100.0)
      @items.sum(&:price) * mult
    end

    def apply_discount(percent)
      @discount = percent
    end
  end

  ##
  # An item with a name and a price
  class Item
    attr_reader :name, :price

    def initialize(name, price)
      @name = name
      @price = price
    end

    def is?(name)
      @name == name
    end
  end
end
