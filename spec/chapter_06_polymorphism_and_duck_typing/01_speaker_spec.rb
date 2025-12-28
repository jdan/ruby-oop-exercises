# frozen_string_literal: true

require 'chapter_06_polymorphism_and_duck_typing/01_speaker'

RSpec.describe Dog do
  describe '#speak' do
    it 'returns Woof!' do
      dog = Dog.new('Rex')
      expect(dog.speak).to eq('Woof!')
    end
  end

  describe '#name' do
    it 'returns the dog name' do
      dog = Dog.new('Buddy')
      expect(dog.name).to eq('Buddy')
    end
  end
end

RSpec.describe Cat do
  describe '#speak' do
    it 'returns Meow!' do
      cat = Cat.new('Whiskers')
      expect(cat.speak).to eq('Meow!')
    end
  end

  describe '#name' do
    it 'returns the cat name' do
      cat = Cat.new('Mittens')
      expect(cat.name).to eq('Mittens')
    end
  end
end

RSpec.describe Robot do
  describe '#speak' do
    it 'returns Beep boop!' do
      robot = Robot.new('R2D2')
      expect(robot.speak).to eq('Beep boop!')
    end
  end

  describe '#name' do
    it 'returns the robot name' do
      robot = Robot.new('C3PO')
      expect(robot.name).to eq('C3PO')
    end
  end
end

RSpec.describe SilentObject do
  describe '#name' do
    it 'returns the object name' do
      obj = SilentObject.new('Rock')
      expect(obj.name).to eq('Rock')
    end
  end

  it 'does not respond to speak' do
    obj = SilentObject.new('Rock')
    expect(obj.respond_to?(:speak)).to be false
  end
end

RSpec.describe 'make_them_speak' do
  it 'calls speak on objects that can speak' do
    dog = Dog.new('Rex')
    cat = Cat.new('Whiskers')
    robot = Robot.new('R2D2')

    result = make_them_speak([dog, cat, robot])

    expect(result).to eq(['Rex says: Woof!', 'Whiskers says: Meow!', 'R2D2 says: Beep boop!'])
  end

  it 'skips objects that cannot speak (duck typing)' do
    dog = Dog.new('Rex')
    rock = SilentObject.new('Rock')
    cat = Cat.new('Whiskers')

    result = make_them_speak([dog, rock, cat])

    expect(result).to eq(['Rex says: Woof!', 'Whiskers says: Meow!'])
  end

  it 'returns empty array when no objects can speak' do
    rock = SilentObject.new('Rock')
    stone = SilentObject.new('Stone')

    result = make_them_speak([rock, stone])

    expect(result).to eq([])
  end
end
