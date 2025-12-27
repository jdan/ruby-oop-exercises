# frozen_string_literal: true

require 'chapter_01_classes_and_objects/03_rectangle'

RSpec.describe Rectangle do
  describe '#initialize' do
    it 'creates a rectangle with width and height' do
      rect = Rectangle.new(10, 5)
      expect(rect).to be_a(Rectangle)
    end
  end

  describe '#area' do
    it 'returns width times height' do
      rect = Rectangle.new(10, 5)
      expect(rect.area).to eq(50)
    end

    it 'works with different dimensions' do
      rect = Rectangle.new(7, 3)
      expect(rect.area).to eq(21)
    end

    it 'handles square dimensions' do
      rect = Rectangle.new(4, 4)
      expect(rect.area).to eq(16)
    end
  end

  describe '#perimeter' do
    it 'returns 2 times width plus height' do
      rect = Rectangle.new(10, 5)
      expect(rect.perimeter).to eq(30)
    end

    it 'works with different dimensions' do
      rect = Rectangle.new(7, 3)
      expect(rect.perimeter).to eq(20)
    end
  end

  describe '#square?' do
    it 'returns true when width equals height' do
      rect = Rectangle.new(5, 5)
      expect(rect.square?).to be true
    end

    it 'returns false when width does not equal height' do
      rect = Rectangle.new(5, 10)
      expect(rect.square?).to be false
    end
  end
end
