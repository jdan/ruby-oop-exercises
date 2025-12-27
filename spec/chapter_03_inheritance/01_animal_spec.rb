# frozen_string_literal: true

require 'chapter_03_inheritance/01_animal'

RSpec.describe 'Animal hierarchy' do
  describe Animal do
    it 'can be created with a name' do
      animal = Animal.new('Generic')
      expect(animal.name).to eq('Generic')
    end

    it 'has a default speak method' do
      animal = Animal.new('Generic')
      expect(animal.speak).to eq('Some sound')
    end
  end

  describe Wolf do
    it 'inherits from Animal' do
      expect(Wolf.superclass).to eq(Animal)
    end

    it 'can be created with a name' do
      wolf = Wolf.new('Grey')
      expect(wolf.name).to eq('Grey')
    end

    it 'overrides speak to return "Howl!"' do
      wolf = Wolf.new('Grey')
      expect(wolf.speak).to eq('Howl!')
    end

    it 'is an Animal' do
      wolf = Wolf.new('Grey')
      expect(wolf).to be_a(Animal)
    end
  end

  describe Tiger do
    it 'inherits from Animal' do
      expect(Tiger.superclass).to eq(Animal)
    end

    it 'can be created with a name' do
      tiger = Tiger.new('Stripes')
      expect(tiger.name).to eq('Stripes')
    end

    it 'overrides speak to return "Roar!"' do
      tiger = Tiger.new('Stripes')
      expect(tiger.speak).to eq('Roar!')
    end

    it 'is an Animal' do
      tiger = Tiger.new('Stripes')
      expect(tiger).to be_a(Animal)
    end
  end
end
