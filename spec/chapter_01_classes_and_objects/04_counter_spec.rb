# frozen_string_literal: true

require 'chapter_01_classes_and_objects/04_counter'

RSpec.describe Counter do
  describe '#initialize' do
    it 'starts at 0 by default' do
      counter = Counter.new
      expect(counter.value).to eq(0)
    end

    it 'can start at a custom value' do
      counter = Counter.new(10)
      expect(counter.value).to eq(10)
    end
  end

  describe '#increment' do
    it 'increases the value by 1' do
      counter = Counter.new
      counter.increment
      expect(counter.value).to eq(1)
    end

    it 'can be called multiple times' do
      counter = Counter.new
      counter.increment
      counter.increment
      counter.increment
      expect(counter.value).to eq(3)
    end
  end

  describe '#decrement' do
    it 'decreases the value by 1' do
      counter = Counter.new(5)
      counter.decrement
      expect(counter.value).to eq(4)
    end

    it 'can go negative' do
      counter = Counter.new(0)
      counter.decrement
      expect(counter.value).to eq(-1)
    end
  end

  describe '#reset' do
    it 'resets to the initial value' do
      counter = Counter.new(10)
      counter.increment
      counter.increment
      counter.reset
      expect(counter.value).to eq(10)
    end

    it 'resets to 0 when no initial value was given' do
      counter = Counter.new
      counter.increment
      counter.increment
      counter.reset
      expect(counter.value).to eq(0)
    end
  end
end
