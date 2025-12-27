# frozen_string_literal: true

require 'chapter_04_modules_and_mixins/05_serializable'

RSpec.describe Serializable do
  describe '#to_hash' do
    it 'returns a hash of serializable attributes for User' do
      user = User.new('Alice', 'alice@example.com')

      result = user.to_hash

      expect(result).to eq({ name: 'Alice', email: 'alice@example.com' })
    end

    it 'returns a hash of serializable attributes for Product' do
      product = Product.new('Widget', 29.99)

      result = product.to_hash

      expect(result).to eq({ name: 'Widget', price: 29.99 })
    end
  end

  describe '#to_json' do
    it 'returns a JSON string for User' do
      user = User.new('Bob', 'bob@example.com')

      result = user.to_json

      expect(result).to eq('{"name":"Bob","email":"bob@example.com"}')
    end

    it 'returns a JSON string for Product' do
      product = Product.new('Gadget', 49.99)

      result = product.to_json

      expect(result).to eq('{"name":"Gadget","price":49.99}')
    end
  end

  describe '.serializable_attributes' do
    it 'defines which attributes are serializable' do
      expect(User.serializable_attrs).to contain_exactly(:name, :email)
    end

    it 'can define different attributes for different classes' do
      expect(Product.serializable_attrs).to contain_exactly(:name, :price)
    end
  end
end

RSpec.describe User do
  describe '#initialize' do
    it 'accepts name and email' do
      user = User.new('Charlie', 'charlie@example.com')

      expect(user.name).to eq('Charlie')
      expect(user.email).to eq('charlie@example.com')
    end
  end

  describe 'module inclusion' do
    it 'includes the Serializable module' do
      expect(User.included_modules).to include(Serializable)
    end
  end
end

RSpec.describe Product do
  describe '#initialize' do
    it 'accepts name and price' do
      product = Product.new('Book', 19.99)

      expect(product.name).to eq('Book')
      expect(product.price).to eq(19.99)
    end
  end

  describe 'module inclusion' do
    it 'includes the Serializable module' do
      expect(Product.included_modules).to include(Serializable)
    end
  end
end
