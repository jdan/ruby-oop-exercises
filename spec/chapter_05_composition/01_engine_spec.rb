# frozen_string_literal: true

require 'chapter_05_composition/01_engine'

RSpec.describe Chapter05::Engine do
  describe '#initialize' do
    it 'creates an engine with horsepower' do
      engine = described_class.new(200)
      expect(engine.horsepower).to eq(200)
    end

    it 'starts in a stopped state' do
      engine = described_class.new(150)
      expect(engine.running?).to be false
    end
  end

  describe '#start' do
    it 'starts the engine' do
      engine = described_class.new(200)
      engine.start
      expect(engine.running?).to be true
    end
  end

  describe '#stop' do
    it 'stops the engine' do
      engine = described_class.new(200)
      engine.start
      engine.stop
      expect(engine.running?).to be false
    end
  end
end

RSpec.describe Chapter05::Car do
  describe '#initialize' do
    it 'creates a car with a model and an engine' do
      engine = Chapter05::Engine.new(180)
      car = described_class.new('Honda Civic', engine)

      expect(car.model).to eq('Honda Civic')
      expect(car.engine).to eq(engine)
    end
  end

  describe '#start' do
    it 'delegates to the engine to start' do
      engine = Chapter05::Engine.new(180)
      car = described_class.new('Honda Civic', engine)

      car.start
      expect(engine.running?).to be true
    end
  end

  describe '#stop' do
    it 'delegates to the engine to stop' do
      engine = Chapter05::Engine.new(180)
      car = described_class.new('Honda Civic', engine)

      car.start
      car.stop
      expect(engine.running?).to be false
    end
  end

  describe '#running?' do
    it 'returns true when the engine is running' do
      engine = Chapter05::Engine.new(180)
      car = described_class.new('Honda Civic', engine)

      car.start
      expect(car.running?).to be true
    end

    it 'returns false when the engine is stopped' do
      engine = Chapter05::Engine.new(180)
      car = described_class.new('Honda Civic', engine)

      expect(car.running?).to be false
    end
  end

  describe '#specs' do
    it 'returns a string with model and horsepower' do
      engine = Chapter05::Engine.new(180)
      car = described_class.new('Honda Civic', engine)

      expect(car.specs).to eq('Honda Civic with 180hp engine')
    end
  end
end
