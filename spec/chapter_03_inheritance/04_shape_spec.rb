# frozen_string_literal: true

require 'chapter_03_inheritance/04_shape'

RSpec.describe 'Shape hierarchy' do
  describe Shape do
    it 'raises NotImplementedError for area' do
      shape = Shape.new
      expect { shape.area }.to raise_error(NotImplementedError)
    end

    it 'raises NotImplementedError for perimeter' do
      shape = Shape.new
      expect { shape.perimeter }.to raise_error(NotImplementedError)
    end
  end

  describe Circle do
    it 'inherits from Shape' do
      expect(Circle.superclass).to eq(Shape)
    end

    it 'can be created with a radius' do
      circle = Circle.new(5)
      expect(circle).to be_a(Circle)
    end

    it 'calculates area correctly' do
      circle = Circle.new(5)
      expected_area = Math::PI * 25 # PI * r^2
      expect(circle.area).to be_within(0.001).of(expected_area)
    end

    it 'calculates perimeter (circumference) correctly' do
      circle = Circle.new(5)
      expected_perimeter = 2 * Math::PI * 5 # 2 * PI * r
      expect(circle.perimeter).to be_within(0.001).of(expected_perimeter)
    end

    it 'is a Shape' do
      circle = Circle.new(5)
      expect(circle).to be_a(Shape)
    end
  end

  describe Square do
    it 'inherits from Shape' do
      expect(Square.superclass).to eq(Shape)
    end

    it 'can be created with a side length' do
      square = Square.new(4)
      expect(square).to be_a(Square)
    end

    it 'calculates area correctly' do
      square = Square.new(4)
      expect(square.area).to eq(16)
    end

    it 'calculates perimeter correctly' do
      square = Square.new(4)
      expect(square.perimeter).to eq(16)
    end

    it 'is a Shape' do
      square = Square.new(4)
      expect(square).to be_a(Shape)
    end
  end
end
