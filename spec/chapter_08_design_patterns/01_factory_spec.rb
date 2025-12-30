# frozen_string_literal: true

require 'chapter_08_design_patterns/01_factory'

RSpec.describe Chapter08::Circle do
  describe '#initialize' do
    it 'creates a circle with a radius' do
      circle = described_class.new(5)
      expect(circle.radius).to eq(5)
    end
  end

  describe '#name' do
    it 'returns "Circle"' do
      circle = described_class.new(5)
      expect(circle.name).to eq('Circle')
    end
  end

  describe '#area' do
    it 'returns pi * radius^2' do
      circle = described_class.new(5)
      expect(circle.area).to be_within(0.01).of(78.54)
    end

    it 'works with different radii' do
      circle = described_class.new(10)
      expect(circle.area).to be_within(0.01).of(314.16)
    end
  end
end

RSpec.describe Chapter08::Square do
  describe '#initialize' do
    it 'creates a square with a side length' do
      square = described_class.new(4)
      expect(square.side).to eq(4)
    end
  end

  describe '#name' do
    it 'returns "Square"' do
      square = described_class.new(4)
      expect(square.name).to eq('Square')
    end
  end

  describe '#area' do
    it 'returns side^2' do
      square = described_class.new(4)
      expect(square.area).to eq(16)
    end

    it 'works with different sides' do
      square = described_class.new(7)
      expect(square.area).to eq(49)
    end
  end
end

RSpec.describe Chapter08::Triangle do
  describe '#initialize' do
    it 'creates a triangle with base and height' do
      triangle = described_class.new(6, 4)
      expect(triangle.base).to eq(6)
      expect(triangle.height).to eq(4)
    end
  end

  describe '#name' do
    it 'returns "Triangle"' do
      triangle = described_class.new(6, 4)
      expect(triangle.name).to eq('Triangle')
    end
  end

  describe '#area' do
    it 'returns 0.5 * base * height' do
      triangle = described_class.new(6, 4)
      expect(triangle.area).to eq(12)
    end

    it 'works with different dimensions' do
      triangle = described_class.new(10, 5)
      expect(triangle.area).to eq(25)
    end
  end
end

RSpec.describe Chapter08::ShapeFactory do
  describe '.create' do
    it 'creates a circle when given :circle and radius' do
      shape = described_class.create(:circle, radius: 5)
      expect(shape).to be_a(Chapter08::Circle)
      expect(shape.radius).to eq(5)
    end

    it 'creates a square when given :square and side' do
      shape = described_class.create(:square, side: 4)
      expect(shape).to be_a(Chapter08::Square)
      expect(shape.side).to eq(4)
    end

    it 'creates a triangle when given :triangle, base, and height' do
      shape = described_class.create(:triangle, base: 6, height: 4)
      expect(shape).to be_a(Chapter08::Triangle)
      expect(shape.base).to eq(6)
      expect(shape.height).to eq(4)
    end

    it 'raises an error for unknown shape types' do
      expect { described_class.create(:hexagon) }.to raise_error(ArgumentError, /Unknown shape/)
    end
  end
end
