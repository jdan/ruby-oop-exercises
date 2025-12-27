# frozen_string_literal: true

require 'chapter_03_inheritance/02_vehicle'

RSpec.describe 'Vehicle hierarchy' do
  describe Vehicle do
    it 'can be created with make, model, and year' do
      vehicle = Vehicle.new('Toyota', 'Camry', 2020)
      expect(vehicle.make).to eq('Toyota')
      expect(vehicle.model).to eq('Camry')
      expect(vehicle.year).to eq(2020)
    end

    it 'has an info method' do
      vehicle = Vehicle.new('Toyota', 'Camry', 2020)
      expect(vehicle.info).to eq('2020 Toyota Camry')
    end
  end

  describe Car do
    it 'inherits from Vehicle' do
      expect(Car.superclass).to eq(Vehicle)
    end

    it 'can be created with make, model, year, and num_doors' do
      car = Car.new('Honda', 'Civic', 2021, 4)
      expect(car.make).to eq('Honda')
      expect(car.model).to eq('Civic')
      expect(car.year).to eq(2021)
      expect(car.num_doors).to eq(4)
    end

    it 'inherits the info method' do
      car = Car.new('Honda', 'Civic', 2021, 4)
      expect(car.info).to eq('2021 Honda Civic')
    end

    it 'is a Vehicle' do
      car = Car.new('Honda', 'Civic', 2021, 4)
      expect(car).to be_a(Vehicle)
    end
  end

  describe Motorcycle do
    it 'inherits from Vehicle' do
      expect(Motorcycle.superclass).to eq(Vehicle)
    end

    it 'can be created with make, model, year, and sidecar option' do
      bike = Motorcycle.new('Harley-Davidson', 'Sportster', 2022, false)
      expect(bike.make).to eq('Harley-Davidson')
      expect(bike.model).to eq('Sportster')
      expect(bike.year).to eq(2022)
    end

    it 'has a has_sidecar? method' do
      bike_with = Motorcycle.new('Ural', 'Gear Up', 2021, true)
      bike_without = Motorcycle.new('Harley-Davidson', 'Sportster', 2022, false)
      expect(bike_with.has_sidecar?).to be true
      expect(bike_without.has_sidecar?).to be false
    end

    it 'inherits the info method' do
      bike = Motorcycle.new('Ducati', 'Monster', 2023, false)
      expect(bike.info).to eq('2023 Ducati Monster')
    end
  end
end
