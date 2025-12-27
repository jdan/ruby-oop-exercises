# frozen_string_literal: true

require 'chapter_02_encapsulation/05_shopping_cart'

RSpec.describe ShoppingCart do
  describe '#initialize' do
    it 'creates an empty shopping cart' do
      cart = ShoppingCart.new
      expect(cart.item_count).to eq(0)
    end
  end

  describe '#add_item' do
    it 'adds an item with name and price' do
      cart = ShoppingCart.new
      cart.add_item('Apple', 1.50)
      expect(cart.item_count).to eq(1)
    end

    it 'can add multiple items' do
      cart = ShoppingCart.new
      cart.add_item('Apple', 1.50)
      cart.add_item('Banana', 0.75)
      cart.add_item('Orange', 2.00)
      expect(cart.item_count).to eq(3)
    end
  end

  describe '#remove_item' do
    it 'removes an item by name' do
      cart = ShoppingCart.new
      cart.add_item('Apple', 1.50)
      cart.add_item('Banana', 0.75)
      cart.remove_item('Apple')
      expect(cart.item_count).to eq(1)
    end

    it 'does nothing if item not found' do
      cart = ShoppingCart.new
      cart.add_item('Apple', 1.50)
      cart.remove_item('Orange')
      expect(cart.item_count).to eq(1)
    end
  end

  describe '#total' do
    it 'returns 0 for empty cart' do
      cart = ShoppingCart.new
      expect(cart.total).to eq(0)
    end

    it 'returns the sum of all item prices' do
      cart = ShoppingCart.new
      cart.add_item('Apple', 1.50)
      cart.add_item('Banana', 0.75)
      cart.add_item('Orange', 2.00)
      expect(cart.total).to eq(4.25)
    end

    it 'updates after removing items' do
      cart = ShoppingCart.new
      cart.add_item('Apple', 1.50)
      cart.add_item('Banana', 0.75)
      cart.remove_item('Apple')
      expect(cart.total).to eq(0.75)
    end
  end

  describe '#item_count' do
    it 'returns the number of items' do
      cart = ShoppingCart.new
      expect(cart.item_count).to eq(0)
      cart.add_item('Apple', 1.50)
      expect(cart.item_count).to eq(1)
    end
  end

  describe '#apply_discount' do
    it 'reduces the total by the given percentage' do
      cart = ShoppingCart.new
      cart.add_item('Item', 100.00)
      cart.apply_discount(10)
      expect(cart.total).to eq(90.00)
    end

    it 'works with multiple items' do
      cart = ShoppingCart.new
      cart.add_item('Item1', 50.00)
      cart.add_item('Item2', 50.00)
      cart.apply_discount(20)
      expect(cart.total).to eq(80.00)
    end
  end

  describe 'encapsulation' do
    it 'does not expose items directly' do
      cart = ShoppingCart.new
      expect(cart).not_to respond_to(:items)
    end
  end
end
