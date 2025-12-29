# frozen_string_literal: true

require 'chapter_01_classes_and_objects/01_dog'

RSpec.describe Chapter01::Dog do
  describe '#initialize' do
    it 'creates a dog with a name and breed' do
      dog = described_class.new('Buddy', 'Golden Retriever')
      expect(dog).to be_a(described_class)
    end
  end

  describe '#bark' do
    it 'returns "Woof!"' do
      dog = described_class.new('Buddy', 'Golden Retriever')
      expect(dog.bark).to eq('Woof!')
    end
  end

  describe '#describe' do
    it 'returns a description with name and breed' do
      dog = described_class.new('Buddy', 'Golden Retriever')
      expect(dog.describe).to eq('Buddy is a Golden Retriever')
    end

    it 'works with different dogs' do
      dog = described_class.new('Max', 'German Shepherd')
      expect(dog.describe).to eq('Max is a German Shepherd')
    end
  end
end
