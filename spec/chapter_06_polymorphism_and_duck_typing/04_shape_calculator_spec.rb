# frozen_string_literal: true

require 'chapter_06_polymorphism_and_duck_typing/04_shape_calculator'

RSpec.describe Chapter06::Circle do
  describe '#initialize' do
    it 'creates a circle with radius' do
      circle = described_class.new(5)

      expect(circle.radius).to eq(5)
    end
  end

  describe '#area' do
    it 'calculates area using PI * r^2' do
      circle = described_class.new(5)

      expect(circle.area).to be_within(0.01).of(78.54)
    end

    it 'works with radius 1' do
      circle = described_class.new(1)

      expect(circle.area).to be_within(0.01).of(Math::PI)
    end
  end

  describe '#perimeter' do
    it 'calculates perimeter using 2 * PI * r' do
      circle = described_class.new(5)

      expect(circle.perimeter).to be_within(0.01).of(31.42)
    end
  end

  describe '#shape_type' do
    it 'returns circle' do
      expect(described_class.new(1).shape_type).to eq('circle')
    end
  end
end

RSpec.describe Chapter06::Rectangle do
  describe '#initialize' do
    it 'creates a rectangle with width and height' do
      rect = described_class.new(4, 6)

      expect(rect.width).to eq(4)
      expect(rect.height).to eq(6)
    end
  end

  describe '#area' do
    it 'calculates area as width * height' do
      rect = described_class.new(4, 6)

      expect(rect.area).to eq(24)
    end
  end

  describe '#perimeter' do
    it 'calculates perimeter as 2 * (width + height)' do
      rect = described_class.new(4, 6)

      expect(rect.perimeter).to eq(20)
    end
  end

  describe '#shape_type' do
    it 'returns rectangle' do
      expect(described_class.new(1, 1).shape_type).to eq('rectangle')
    end
  end
end

RSpec.describe Chapter06::Triangle do
  describe '#initialize' do
    it 'creates a triangle with base, height, and three sides' do
      triangle = described_class.new(3, 4, 3, 4, 5)

      expect(triangle.base).to eq(3)
      expect(triangle.height).to eq(4)
    end
  end

  describe '#area' do
    it 'calculates area as 0.5 * base * height' do
      triangle = described_class.new(6, 4, 5, 5, 6)

      expect(triangle.area).to eq(12.0)
    end
  end

  describe '#perimeter' do
    it 'calculates perimeter as sum of all sides' do
      triangle = described_class.new(3, 4, 3, 4, 5)

      expect(triangle.perimeter).to eq(12)
    end
  end

  describe '#shape_type' do
    it 'returns triangle' do
      expect(described_class.new(3, 4, 3, 4, 5).shape_type).to eq('triangle')
    end
  end
end

RSpec.describe Chapter06::ShapeCalculator do
  describe '#total_area' do
    it 'sums areas of all shapes' do
      circle = Chapter06::Circle.new(1) # area ~= 3.14
      rect = Chapter06::Rectangle.new(2, 3) # area = 6
      calculator = described_class.new

      result = calculator.total_area([circle, rect])

      expect(result).to be_within(0.01).of(9.14)
    end

    it 'works with different shape types' do
      triangle = Chapter06::Triangle.new(4, 3, 3, 4, 5) # area = 6
      rect = Chapter06::Rectangle.new(5, 5) # area = 25
      calculator = described_class.new

      result = calculator.total_area([triangle, rect])

      expect(result).to eq(31)
    end

    it 'returns 0 for empty array' do
      calculator = described_class.new

      expect(calculator.total_area([])).to eq(0)
    end
  end

  describe '#total_perimeter' do
    it 'sums perimeters of all shapes' do
      rect = Chapter06::Rectangle.new(3, 4) # perimeter = 14
      triangle = Chapter06::Triangle.new(3, 4, 3, 4, 5) # perimeter = 12
      calculator = described_class.new

      result = calculator.total_perimeter([rect, triangle])

      expect(result).to eq(26)
    end
  end

  describe '#largest_shape' do
    it 'returns shape with largest area' do
      small_circle = Chapter06::Circle.new(1)
      large_rect = Chapter06::Rectangle.new(10, 10)
      medium_triangle = Chapter06::Triangle.new(6, 8, 6, 8, 10)
      calculator = described_class.new

      result = calculator.largest_shape([small_circle, large_rect, medium_triangle])

      expect(result).to eq(large_rect)
    end

    it 'returns nil for empty array' do
      calculator = described_class.new

      expect(calculator.largest_shape([])).to be_nil
    end
  end

  describe '#shapes_report' do
    it 'returns formatted report of all shapes' do
      circle = Chapter06::Circle.new(2)
      rect = Chapter06::Rectangle.new(3, 4)
      calculator = described_class.new

      result = calculator.shapes_report([circle, rect])

      expect(result[0]).to include('circle: area = ')
      expect(result[1]).to include('rectangle: area = 12')
    end
  end
end
