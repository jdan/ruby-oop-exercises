# frozen_string_literal: true

require 'chapter_03_inheritance/05_game_character'

RSpec.describe 'GameCharacter hierarchy' do
  describe Chapter03::Character do
    it 'can be created with name and health' do
      char = described_class.new('Hero', 100)
      expect(char.name).to eq('Hero')
      expect(char.health).to eq(100)
    end

    it 'has an attack method' do
      char = described_class.new('Hero', 100)
      expect(char.attack).to eq('Hero attacks!')
    end

    it 'has a defend method' do
      char = described_class.new('Hero', 100)
      expect(char.defend).to eq('Hero defends!')
    end

    it 'can take damage' do
      char = described_class.new('Hero', 100)
      char.take_damage(30)
      expect(char.health).to eq(70)
    end

    it 'health cannot go below 0' do
      char = described_class.new('Hero', 50)
      char.take_damage(100)
      expect(char.health).to eq(0)
    end

    it 'knows if character is alive' do
      char = described_class.new('Hero', 100)
      expect(char.alive?).to be true
      char.take_damage(100)
      expect(char.alive?).to be false
    end
  end

  describe Chapter03::Warrior do
    it 'inherits from Character' do
      expect(described_class.superclass).to eq(Chapter03::Character)
    end

    it 'can be created with name, health, and strength' do
      warrior = described_class.new('Conan', 150, 25)
      expect(warrior.name).to eq('Conan')
      expect(warrior.health).to eq(150)
      expect(warrior.strength).to eq(25)
    end

    it 'overrides attack method' do
      warrior = described_class.new('Conan', 150, 25)
      expect(warrior.attack).to eq('Conan swings sword for 25 damage!')
    end

    it 'has a special_move method' do
      warrior = described_class.new('Conan', 150, 25)
      expect(warrior.special_move).to eq('Conan uses Shield Bash!')
    end

    it 'inherits defend method' do
      warrior = described_class.new('Conan', 150, 25)
      expect(warrior.defend).to eq('Conan defends!')
    end

    it 'is a Character' do
      warrior = described_class.new('Conan', 150, 25)
      expect(warrior).to be_a(Chapter03::Character)
    end
  end

  describe Chapter03::Mage do
    it 'inherits from Character' do
      expect(described_class.superclass).to eq(Chapter03::Character)
    end

    it 'can be created with name, health, and mana' do
      mage = described_class.new('Gandalf', 80, 100)
      expect(mage.name).to eq('Gandalf')
      expect(mage.health).to eq(80)
      expect(mage.mana).to eq(100)
    end

    it 'overrides attack method' do
      mage = described_class.new('Gandalf', 80, 100)
      expect(mage.attack).to eq('Gandalf casts fireball!')
    end

    it 'has a special_move that costs mana' do
      mage = described_class.new('Gandalf', 80, 50)
      expect(mage.special_move).to eq('Gandalf casts Arcane Blast!')
      expect(mage.mana).to eq(40)
    end

    it 'cannot use special_move without enough mana' do
      mage = described_class.new('Gandalf', 80, 5)
      expect(mage.special_move).to eq('Gandalf is out of mana!')
      expect(mage.mana).to eq(5) # mana unchanged
    end

    it 'inherits defend method' do
      mage = described_class.new('Gandalf', 80, 100)
      expect(mage.defend).to eq('Gandalf defends!')
    end

    it 'is a Character' do
      mage = described_class.new('Gandalf', 80, 100)
      expect(mage).to be_a(Chapter03::Character)
    end
  end
end
