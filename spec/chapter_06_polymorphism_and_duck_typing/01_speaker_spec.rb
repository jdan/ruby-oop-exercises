# frozen_string_literal: true

require 'chapter_06_polymorphism_and_duck_typing/01_speaker'

RSpec.describe Chapter06::Dog do
  describe '#speak' do
    it 'returns Woof!' do
      dog = described_class.new('Rex')
      expect(dog.speak).to eq('Woof!')
    end
  end

  describe '#name' do
    it 'returns the dog name' do
      dog = described_class.new('Buddy')
      expect(dog.name).to eq('Buddy')
    end
  end
end

RSpec.describe Chapter06::Cat do
  describe '#speak' do
    it 'returns Meow!' do
      cat = described_class.new('Whiskers')
      expect(cat.speak).to eq('Meow!')
    end
  end

  describe '#name' do
    it 'returns the cat name' do
      cat = described_class.new('Mittens')
      expect(cat.name).to eq('Mittens')
    end
  end
end

RSpec.describe Chapter06::Robot do
  describe '#speak' do
    it 'returns Beep boop!' do
      robot = described_class.new('R2D2')
      expect(robot.speak).to eq('Beep boop!')
    end
  end

  describe '#name' do
    it 'returns the robot name' do
      robot = described_class.new('C3PO')
      expect(robot.name).to eq('C3PO')
    end
  end
end

RSpec.describe Chapter06::SilentObject do
  describe '#name' do
    it 'returns the object name' do
      obj = described_class.new('Rock')
      expect(obj.name).to eq('Rock')
    end
  end

  it 'does not respond to speak' do
    obj = described_class.new('Rock')
    expect(obj.respond_to?(:speak)).to be false
  end
end

RSpec.describe 'Chapter06.make_them_speak' do
  it 'calls speak on objects that can speak' do
    dog = Chapter06::Dog.new('Rex')
    cat = Chapter06::Cat.new('Whiskers')
    robot = Chapter06::Robot.new('R2D2')

    result = Chapter06.make_them_speak([dog, cat, robot])

    expect(result).to eq(['Rex says: Woof!', 'Whiskers says: Meow!', 'R2D2 says: Beep boop!'])
  end

  it 'skips objects that cannot speak (duck typing)' do
    dog = Chapter06::Dog.new('Rex')
    rock = Chapter06::SilentObject.new('Rock')
    cat = Chapter06::Cat.new('Whiskers')

    result = Chapter06.make_them_speak([dog, rock, cat])

    expect(result).to eq(['Rex says: Woof!', 'Whiskers says: Meow!'])
  end

  it 'returns empty array when no objects can speak' do
    rock = Chapter06::SilentObject.new('Rock')
    stone = Chapter06::SilentObject.new('Stone')

    result = Chapter06.make_them_speak([rock, stone])

    expect(result).to eq([])
  end
end
