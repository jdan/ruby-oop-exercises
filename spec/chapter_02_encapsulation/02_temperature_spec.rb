# frozen_string_literal: true

require 'chapter_02_encapsulation/02_temperature'

RSpec.describe Temperature do
  describe '#initialize' do
    it 'creates a temperature with Celsius value' do
      temp = Temperature.new(25)
      expect(temp).to be_a(Temperature)
    end
  end

  describe '#celsius' do
    it 'returns the temperature in Celsius' do
      temp = Temperature.new(25)
      expect(temp.celsius).to eq(25)
    end

    it 'can be changed' do
      temp = Temperature.new(25)
      temp.celsius = 30
      expect(temp.celsius).to eq(30)
    end
  end

  describe '#fahrenheit' do
    it 'converts 0 Celsius to 32 Fahrenheit' do
      temp = Temperature.new(0)
      expect(temp.fahrenheit).to eq(32)
    end

    it 'converts 100 Celsius to 212 Fahrenheit' do
      temp = Temperature.new(100)
      expect(temp.fahrenheit).to eq(212)
    end

    it 'converts 25 Celsius to 77 Fahrenheit' do
      temp = Temperature.new(25)
      expect(temp.fahrenheit).to eq(77)
    end
  end

  describe '#kelvin' do
    it 'converts 0 Celsius to 273.15 Kelvin' do
      temp = Temperature.new(0)
      expect(temp.kelvin).to eq(273.15)
    end

    it 'converts -273.15 Celsius to 0 Kelvin (absolute zero)' do
      temp = Temperature.new(-273.15)
      expect(temp.kelvin).to eq(0)
    end

    it 'converts 25 Celsius to 298.15 Kelvin' do
      temp = Temperature.new(25)
      expect(temp.kelvin).to eq(298.15)
    end
  end
end
