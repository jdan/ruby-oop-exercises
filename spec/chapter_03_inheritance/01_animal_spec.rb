# frozen_string_literal: true

require 'chapter_03_inheritance/01_animal'

RSpec.describe 'Animal hierarchy' do
  describe Chapter03::Animal do
    it 'can be created with a name' do
      animal = described_class.new('Generic')
      expect(animal.name).to eq('Generic')
    end

    it 'has a default speak method' do
      animal = described_class.new('Generic')
      expect(animal.speak).to eq('Some sound')
    end
  end

  describe Chapter03::Wolf do
    it 'inherits from Animal' do
      expect(described_class.superclass).to eq(Chapter03::Animal)
    end

    it 'can be created with a name' do
      wolf = described_class.new('Grey')
      expect(wolf.name).to eq('Grey')
    end

    it 'overrides speak to return "Howl!"' do
      wolf = described_class.new('Grey')
      expect(wolf.speak).to eq('Howl!')
    end

    it 'is an Animal' do
      wolf = described_class.new('Grey')
      expect(wolf).to be_a(Chapter03::Animal)
    end
  end

  describe Chapter03::Tiger do
    it 'inherits from Animal' do
      expect(described_class.superclass).to eq(Chapter03::Animal)
    end

    it 'can be created with a name' do
      tiger = described_class.new('Stripes')
      expect(tiger.name).to eq('Stripes')
    end

    it 'overrides speak to return "Roar!"' do
      tiger = described_class.new('Stripes')
      expect(tiger.speak).to eq('Roar!')
    end

    it 'is an Animal' do
      tiger = described_class.new('Stripes')
      expect(tiger).to be_a(Chapter03::Animal)
    end
  end
end
