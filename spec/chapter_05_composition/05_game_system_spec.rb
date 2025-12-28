# frozen_string_literal: true

require 'chapter_05_composition/05_game_system'

RSpec.describe AggressiveStrategy do
  describe '#choose_action' do
    it 'always returns attack' do
      strategy = AggressiveStrategy.new

      expect(strategy.choose_action(100, 50)).to eq(:attack)
      expect(strategy.choose_action(10, 100)).to eq(:attack)
    end
  end

  describe '#name' do
    it 'returns strategy name' do
      expect(AggressiveStrategy.new.name).to eq('Aggressive')
    end
  end
end

RSpec.describe DefensiveStrategy do
  describe '#choose_action' do
    it 'returns defend when health is low (below 30)' do
      strategy = DefensiveStrategy.new

      expect(strategy.choose_action(20, 100)).to eq(:defend)
      expect(strategy.choose_action(29, 50)).to eq(:defend)
    end

    it 'returns attack when health is 30 or above' do
      strategy = DefensiveStrategy.new

      expect(strategy.choose_action(30, 100)).to eq(:attack)
      expect(strategy.choose_action(100, 50)).to eq(:attack)
    end
  end

  describe '#name' do
    it 'returns strategy name' do
      expect(DefensiveStrategy.new.name).to eq('Defensive')
    end
  end
end

RSpec.describe BalancedStrategy do
  describe '#choose_action' do
    it 'returns heal when health is below 50' do
      strategy = BalancedStrategy.new

      expect(strategy.choose_action(30, 100)).to eq(:heal)
      expect(strategy.choose_action(49, 50)).to eq(:heal)
    end

    it 'returns attack when health is 50 or above' do
      strategy = BalancedStrategy.new

      expect(strategy.choose_action(50, 100)).to eq(:attack)
      expect(strategy.choose_action(100, 50)).to eq(:attack)
    end
  end

  describe '#name' do
    it 'returns strategy name' do
      expect(BalancedStrategy.new.name).to eq('Balanced')
    end
  end
end

RSpec.describe GameCharacter do
  describe '#initialize' do
    it 'creates a character with name, health, and strategy' do
      strategy = AggressiveStrategy.new
      character = GameCharacter.new('Warrior', 100, strategy)

      expect(character.name).to eq('Warrior')
      expect(character.health).to eq(100)
    end
  end

  describe '#take_turn' do
    it 'delegates action choice to strategy' do
      strategy = AggressiveStrategy.new
      character = GameCharacter.new('Warrior', 100, strategy)

      expect(character.take_turn(50)).to eq(:attack)
    end

    it 'uses defensive strategy when configured' do
      strategy = DefensiveStrategy.new
      character = GameCharacter.new('Knight', 25, strategy)

      expect(character.take_turn(100)).to eq(:defend)
    end

    it 'uses balanced strategy when configured' do
      strategy = BalancedStrategy.new
      character = GameCharacter.new('Paladin', 40, strategy)

      expect(character.take_turn(100)).to eq(:heal)
    end
  end

  describe '#change_strategy' do
    it 'allows changing strategy at runtime' do
      aggressive = AggressiveStrategy.new
      defensive = DefensiveStrategy.new
      character = GameCharacter.new('Fighter', 20, aggressive)

      expect(character.take_turn(100)).to eq(:attack)

      character.change_strategy(defensive)
      expect(character.take_turn(100)).to eq(:defend)
    end
  end

  describe '#take_damage' do
    it 'reduces health by the damage amount' do
      strategy = AggressiveStrategy.new
      character = GameCharacter.new('Warrior', 100, strategy)

      character.take_damage(30)

      expect(character.health).to eq(70)
    end

    it 'does not reduce health below zero' do
      strategy = AggressiveStrategy.new
      character = GameCharacter.new('Warrior', 20, strategy)

      character.take_damage(50)

      expect(character.health).to eq(0)
    end
  end

  describe '#status' do
    it 'returns character status with strategy name' do
      strategy = BalancedStrategy.new
      character = GameCharacter.new('Mage', 80, strategy)

      expect(character.status).to eq('Mage (HP: 80) using Balanced strategy')
    end
  end
end
