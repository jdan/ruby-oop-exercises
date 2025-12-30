# frozen_string_literal: true

require 'chapter_08_design_patterns/04_decorator'

RSpec.describe Chapter08::Coffee do
  describe '#initialize' do
    it 'creates a basic coffee' do
      coffee = described_class.new
      expect(coffee).to be_a(described_class)
    end
  end

  describe '#cost' do
    it 'returns 2.00 for basic coffee' do
      coffee = described_class.new
      expect(coffee.cost).to eq(2.00)
    end
  end

  describe '#description' do
    it 'returns "Coffee" for basic coffee' do
      coffee = described_class.new
      expect(coffee.description).to eq('Coffee')
    end
  end
end

RSpec.describe Chapter08::MilkDecorator do
  describe '#cost' do
    it 'adds 0.50 to the beverage cost' do
      coffee = Chapter08::Coffee.new
      with_milk = described_class.new(coffee)
      expect(with_milk.cost).to eq(2.50)
    end
  end

  describe '#description' do
    it 'adds "with Milk" to the description' do
      coffee = Chapter08::Coffee.new
      with_milk = described_class.new(coffee)
      expect(with_milk.description).to eq('Coffee with Milk')
    end
  end
end

RSpec.describe Chapter08::SugarDecorator do
  describe '#cost' do
    it 'adds 0.25 to the beverage cost' do
      coffee = Chapter08::Coffee.new
      with_sugar = described_class.new(coffee)
      expect(with_sugar.cost).to eq(2.25)
    end
  end

  describe '#description' do
    it 'adds "with Sugar" to the description' do
      coffee = Chapter08::Coffee.new
      with_sugar = described_class.new(coffee)
      expect(with_sugar.description).to eq('Coffee with Sugar')
    end
  end
end

RSpec.describe Chapter08::WhipDecorator do
  describe '#cost' do
    it 'adds 0.75 to the beverage cost' do
      coffee = Chapter08::Coffee.new
      with_whip = described_class.new(coffee)
      expect(with_whip.cost).to eq(2.75)
    end
  end

  describe '#description' do
    it 'adds "with Whipped Cream" to the description' do
      coffee = Chapter08::Coffee.new
      with_whip = described_class.new(coffee)
      expect(with_whip.description).to eq('Coffee with Whipped Cream')
    end
  end
end

RSpec.describe 'Decorator chaining' do
  it 'can stack multiple decorators' do
    coffee = Chapter08::Coffee.new
    with_milk = Chapter08::MilkDecorator.new(coffee)
    with_milk_and_sugar = Chapter08::SugarDecorator.new(with_milk)

    expect(with_milk_and_sugar.cost).to eq(2.75)
    expect(with_milk_and_sugar.description).to eq('Coffee with Milk with Sugar')
  end

  it 'can stack all decorators' do
    beverage = Chapter08::Coffee.new
    beverage = Chapter08::MilkDecorator.new(beverage)
    beverage = Chapter08::SugarDecorator.new(beverage)
    beverage = Chapter08::WhipDecorator.new(beverage)

    expect(beverage.cost).to eq(3.50)
    expect(beverage.description).to eq('Coffee with Milk with Sugar with Whipped Cream')
  end

  it 'can add the same decorator multiple times' do
    coffee = Chapter08::Coffee.new
    double_sugar = Chapter08::SugarDecorator.new(
      Chapter08::SugarDecorator.new(coffee)
    )

    expect(double_sugar.cost).to eq(2.50)
    expect(double_sugar.description).to eq('Coffee with Sugar with Sugar')
  end
end

RSpec.describe Chapter08::Espresso do
  describe '#cost' do
    it 'returns 3.00 for espresso' do
      espresso = described_class.new
      expect(espresso.cost).to eq(3.00)
    end
  end

  describe '#description' do
    it 'returns "Espresso"' do
      espresso = described_class.new
      expect(espresso.description).to eq('Espresso')
    end
  end

  it 'works with decorators' do
    espresso = described_class.new
    latte = Chapter08::MilkDecorator.new(espresso)

    expect(latte.cost).to eq(3.50)
    expect(latte.description).to eq('Espresso with Milk')
  end
end
