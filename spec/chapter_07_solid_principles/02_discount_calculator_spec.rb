# frozen_string_literal: true

require 'chapter_07_solid_principles/02_discount_calculator'

RSpec.describe Chapter07::PercentageDiscount do
  describe '#initialize' do
    it 'creates a discount with a percentage' do
      discount = described_class.new(10)
      expect(discount.percent).to eq(10)
    end
  end

  describe '#name' do
    it 'returns a descriptive name' do
      discount = described_class.new(15)
      expect(discount.name).to eq('Percentage Discount (15%)')
    end
  end

  describe '#apply' do
    it 'reduces the price by the percentage' do
      discount = described_class.new(10)
      expect(discount.apply(100.0)).to eq(90.0)
    end

    it 'handles decimal percentages' do
      discount = described_class.new(25)
      expect(discount.apply(80.0)).to eq(60.0)
    end
  end

  describe '#description' do
    it 'returns a readable description' do
      discount = described_class.new(20)
      expect(discount.description).to eq('20% off')
    end
  end
end

RSpec.describe Chapter07::FlatDiscount do
  describe '#initialize' do
    it 'creates a discount with a fixed amount' do
      discount = described_class.new(5.00)
      expect(discount.amount).to eq(5.00)
    end
  end

  describe '#name' do
    it 'returns a descriptive name' do
      discount = described_class.new(10.00)
      expect(discount.name).to eq('Flat Discount ($10.0)')
    end
  end

  describe '#apply' do
    it 'subtracts the amount from the price' do
      discount = described_class.new(5.00)
      expect(discount.apply(20.00)).to eq(15.00)
    end

    it 'does not go below zero' do
      discount = described_class.new(50.00)
      expect(discount.apply(20.00)).to eq(0)
    end
  end

  describe '#description' do
    it 'returns a readable description' do
      discount = described_class.new(7.50)
      expect(discount.description).to eq('$7.5 off')
    end
  end
end

RSpec.describe Chapter07::BuyOneGetOneFree do
  describe '#name' do
    it 'returns the discount name' do
      discount = described_class.new
      expect(discount.name).to eq('Buy One Get One Free')
    end
  end

  describe '#apply' do
    it 'reduces the price by 50%' do
      discount = described_class.new
      expect(discount.apply(100.0)).to eq(50.0)
    end
  end

  describe '#description' do
    it 'returns a readable description' do
      discount = described_class.new
      expect(discount.description).to eq('Buy one, get one free')
    end
  end
end

RSpec.describe Chapter07::SeasonalDiscount do
  describe '#initialize' do
    it 'creates a discount with percentage and valid months' do
      discount = described_class.new(20, [11, 12])
      expect(discount.percent).to eq(20)
      expect(discount.valid_months).to eq([11, 12])
    end
  end

  describe '#name' do
    it 'returns the discount name' do
      discount = described_class.new(15, [6, 7, 8])
      expect(discount.name).to eq('Seasonal Discount')
    end
  end

  describe '#applicable?' do
    it 'returns true when current month is in valid months' do
      discount = described_class.new(20, [11, 12])
      expect(discount.applicable?(12)).to be true
    end

    it 'returns false when current month is not in valid months' do
      discount = described_class.new(20, [11, 12])
      expect(discount.applicable?(5)).to be false
    end
  end

  describe '#apply' do
    it 'applies the discount when month is valid' do
      discount = described_class.new(20, [11, 12])
      expect(discount.apply(100.0, current_month: 12)).to eq(80.0)
    end

    it 'returns original price when month is not valid' do
      discount = described_class.new(20, [11, 12])
      expect(discount.apply(100.0, current_month: 5)).to eq(100.0)
    end
  end
end

RSpec.describe Chapter07::PriceCalculator do
  describe '#initialize' do
    it 'accepts any discount object' do
      discount = Chapter07::PercentageDiscount.new(10)
      calculator = described_class.new(discount)
      expect(calculator.discount).to eq(discount)
    end
  end

  describe '#calculate' do
    it 'works with PercentageDiscount' do
      discount = Chapter07::PercentageDiscount.new(10)
      calculator = described_class.new(discount)
      expect(calculator.calculate(100.0)).to eq(90.0)
    end

    it 'works with FlatDiscount' do
      discount = Chapter07::FlatDiscount.new(15.0)
      calculator = described_class.new(discount)
      expect(calculator.calculate(100.0)).to eq(85.0)
    end

    it 'works with BuyOneGetOneFree' do
      discount = Chapter07::BuyOneGetOneFree.new
      calculator = described_class.new(discount)
      expect(calculator.calculate(100.0)).to eq(50.0)
    end
  end

  describe '#calculate_with_month' do
    it 'passes the month to seasonal discounts' do
      discount = Chapter07::SeasonalDiscount.new(25, [12])
      calculator = described_class.new(discount)
      expect(calculator.calculate_with_month(100.0, 12)).to eq(75.0)
    end

    it 'returns original price for non-seasonal month' do
      discount = Chapter07::SeasonalDiscount.new(25, [12])
      calculator = described_class.new(discount)
      expect(calculator.calculate_with_month(100.0, 6)).to eq(100.0)
    end
  end
end
