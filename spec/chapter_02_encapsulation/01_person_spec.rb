# frozen_string_literal: true

require 'chapter_02_encapsulation/01_person'

RSpec.describe Person do
  describe '#initialize' do
    it 'creates a person with name, age, and email' do
      person = Person.new('Alice', 30, 'alice@example.com')
      expect(person).to be_a(Person)
    end
  end

  describe '#name' do
    it 'can read the name' do
      person = Person.new('Alice', 30, 'alice@example.com')
      expect(person.name).to eq('Alice')
    end

    it 'can change the name' do
      person = Person.new('Alice', 30, 'alice@example.com')
      person.name = 'Alicia'
      expect(person.name).to eq('Alicia')
    end
  end

  describe '#age' do
    it 'can read the age' do
      person = Person.new('Bob', 25, 'bob@example.com')
      expect(person.age).to eq(25)
    end

    it 'can change the age' do
      person = Person.new('Bob', 25, 'bob@example.com')
      person.age = 26
      expect(person.age).to eq(26)
    end
  end

  describe '#email' do
    it 'can read the email' do
      person = Person.new('Carol', 35, 'carol@example.com')
      expect(person.email).to eq('carol@example.com')
    end

    it 'cannot change the email directly' do
      person = Person.new('Carol', 35, 'carol@example.com')
      expect { person.email = 'new@example.com' }.to raise_error(NoMethodError)
    end
  end
end
