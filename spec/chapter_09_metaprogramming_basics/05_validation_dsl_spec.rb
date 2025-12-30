# frozen_string_literal: true

require 'chapter_09_metaprogramming_basics/05_validation_dsl'

RSpec.describe Chapter09::Validatable do
  describe '.validates_presence_of' do
    let(:test_class) do
      Class.new do
        include Chapter09::Validatable

        attr_accessor :name

        validates_presence_of :name
      end
    end

    it 'registers a presence validation' do
      obj = test_class.new
      obj.name = nil
      expect(obj.valid?).to be false
    end

    it 'passes when attribute is present' do
      obj = test_class.new
      obj.name = 'Alice'
      expect(obj.valid?).to be true
    end

    it 'fails for empty string' do
      obj = test_class.new
      obj.name = ''
      expect(obj.valid?).to be false
    end
  end

  describe '.validates_length_of' do
    let(:test_class) do
      Class.new do
        include Chapter09::Validatable

        attr_accessor :username

        validates_length_of :username, minimum: 3, maximum: 20
      end
    end

    it 'fails when value is too short' do
      obj = test_class.new
      obj.username = 'ab'
      expect(obj.valid?).to be false
    end

    it 'fails when value is too long' do
      obj = test_class.new
      obj.username = 'a' * 21
      expect(obj.valid?).to be false
    end

    it 'passes when value is within range' do
      obj = test_class.new
      obj.username = 'validuser'
      expect(obj.valid?).to be true
    end
  end

  describe '.validates_numericality_of' do
    let(:test_class) do
      Class.new do
        include Chapter09::Validatable

        attr_accessor :age

        validates_numericality_of :age, greater_than: 0
      end
    end

    it 'fails for non-numeric values' do
      obj = test_class.new
      obj.age = 'not a number'
      expect(obj.valid?).to be false
    end

    it 'fails when not greater than specified value' do
      obj = test_class.new
      obj.age = 0
      expect(obj.valid?).to be false
    end

    it 'passes for valid numeric value' do
      obj = test_class.new
      obj.age = 25
      expect(obj.valid?).to be true
    end
  end
end

RSpec.describe Chapter09::Product do
  describe '#valid?' do
    it 'returns true when all validations pass' do
      product = described_class.new('Widget', 9.99)
      expect(product.valid?).to be true
    end

    it 'returns false when name is blank' do
      product = described_class.new('', 9.99)
      expect(product.valid?).to be false
    end

    it 'returns false when name is nil' do
      product = described_class.new(nil, 9.99)
      expect(product.valid?).to be false
    end

    it 'returns false when name is too short' do
      product = described_class.new('A', 9.99)
      expect(product.valid?).to be false
    end

    it 'returns false when name is too long' do
      product = described_class.new('A' * 51, 9.99)
      expect(product.valid?).to be false
    end

    it 'returns false when price is not numeric' do
      product = described_class.new('Widget', 'free')
      expect(product.valid?).to be false
    end

    it 'returns false when price is zero' do
      product = described_class.new('Widget', 0)
      expect(product.valid?).to be false
    end

    it 'returns false when price is negative' do
      product = described_class.new('Widget', -5)
      expect(product.valid?).to be false
    end
  end

  describe '#errors' do
    it 'returns empty hash when valid' do
      product = described_class.new('Widget', 9.99)
      product.valid?
      expect(product.errors).to be_empty
    end

    it 'returns hash with attribute => messages when invalid' do
      product = described_class.new('', 9.99)
      product.valid?
      expect(product.errors[:name]).to be_an(Array)
      expect(product.errors[:name]).not_to be_empty
    end

    it 'collects multiple errors for same attribute' do
      product = described_class.new('A', -5)
      product.valid?
      expect(product.errors[:name]).not_to be_empty
      expect(product.errors[:price]).not_to be_empty
    end
  end
end

RSpec.describe Chapter09::Order do
  describe '#valid?' do
    it 'returns true for valid order' do
      order = described_class.new('John Doe', 99.99)
      expect(order.valid?).to be true
    end

    it 'returns false when customer_name is blank' do
      order = described_class.new('', 99.99)
      expect(order.valid?).to be false
    end

    it 'returns false when total is not numeric' do
      order = described_class.new('John Doe', 'invalid')
      expect(order.valid?).to be false
    end
  end

  describe 'separate validations from Product' do
    it 'does not share validations with Product class' do
      # Order only validates presence of customer_name, not length
      order = described_class.new('A', 99.99)
      expect(order.valid?).to be true
    end
  end
end
