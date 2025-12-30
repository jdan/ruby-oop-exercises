# frozen_string_literal: true

require 'chapter_09_metaprogramming_basics/01_attribute_accessor'

RSpec.describe Chapter09::AttributeAccessor do
  let(:test_class) do
    Class.new do
      extend Chapter09::AttributeAccessor

      my_attr_accessor :name, :age
    end
  end

  describe '.my_attr_accessor' do
    it 'creates a getter method for each attribute' do
      obj = test_class.new
      obj.instance_variable_set(:@name, 'Alice')
      expect(obj.name).to eq('Alice')
    end

    it 'creates a setter method for each attribute' do
      obj = test_class.new
      obj.name = 'Bob'
      expect(obj.instance_variable_get(:@name)).to eq('Bob')
    end

    it 'handles multiple attributes in one call' do
      obj = test_class.new
      obj.name = 'Charlie'
      obj.age = 30
      expect(obj.name).to eq('Charlie')
      expect(obj.age).to eq(30)
    end

    it 'returns nil for unset attributes' do
      obj = test_class.new
      expect(obj.name).to be_nil
    end
  end
end

RSpec.describe Chapter09::Person do
  describe 'dynamic attributes' do
    it 'has a name getter and setter' do
      person = described_class.new
      person.name = 'Alice'
      expect(person.name).to eq('Alice')
    end

    it 'has an age getter and setter' do
      person = described_class.new
      person.age = 25
      expect(person.age).to eq(25)
    end

    it 'stores values in instance variables' do
      person = described_class.new
      person.name = 'Bob'
      person.age = 30
      expect(person.instance_variable_get(:@name)).to eq('Bob')
      expect(person.instance_variable_get(:@age)).to eq(30)
    end

    it 'allows setting values during initialization if initialize is defined' do
      person = described_class.new
      expect(person.name).to be_nil
      expect(person.age).to be_nil
    end
  end
end
