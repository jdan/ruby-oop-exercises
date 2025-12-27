# frozen_string_literal: true

require 'chapter_04_modules_and_mixins/01_greetable'

RSpec.describe Greetable do
  describe '#greet' do
    it 'returns a greeting with the name' do
      person = Person.new('Alice')

      expect(person.greet).to eq("Hello, I'm Alice!")
    end
  end
end

RSpec.describe Person do
  describe '#initialize' do
    it 'accepts a name' do
      person = Person.new('Bob')

      expect(person.name).to eq('Bob')
    end
  end

  describe '#name' do
    it 'returns the person name' do
      person = Person.new('Charlie')

      expect(person.name).to eq('Charlie')
    end
  end

  describe 'module inclusion' do
    it 'includes the Greetable module' do
      expect(Person.included_modules).to include(Greetable)
    end

    it 'can use the greet method from Greetable' do
      person = Person.new('Diana')

      expect(person.greet).to eq("Hello, I'm Diana!")
    end
  end
end
