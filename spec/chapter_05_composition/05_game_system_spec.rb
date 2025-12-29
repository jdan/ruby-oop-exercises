# frozen_string_literal: true

require 'chapter_05_composition/05_game_system'

RSpec.describe Chapter05::AggressiveStrategy do
  describe '#choose_action' do
    it 'always returns attack' do
      strategy = described_class.new

      expect(strategy.choose_action(100)).to eq(:attack)
      expect(strategy.choose_action(10)).to eq(:attack)
    end
  end

  describe '#name' do
    it 'returns strategy name' do
      expect(described_class.new.name).to eq('Aggressive')
    end
  end
end

RSpec.describe Chapter05::DefensiveStrategy do
  describe '#choose_action' do
    it 'returns defend when health is low (below 30)' do
      strategy = described_class.new

      expect(strategy.choose_action(20)).to eq(:defend)
      expect(strategy.choose_action(29)).to eq(:defend)
    end

    it 'returns attack when health is 30 or above' do
      strategy = described_class.new

      expect(strategy.choose_action(30)).to eq(:attack)
      expect(strategy.choose_action(100)).to eq(:attack)
    end
  end

  describe '#name' do
    it 'returns strategy name' do
      expect(described_class.new.name).to eq('Defensive')
    end
  end
end

RSpec.describe Chapter05::BalancedStrategy do
  describe '#choose_action' do
    it 'returns heal when health is below 50' do
      strategy = described_class.new

      expect(strategy.choose_action(30)).to eq(:heal)
      expect(strategy.choose_action(49)).to eq(:heal)
    end

    it 'returns attack when health is 50 or above' do
      strategy = described_class.new

      expect(strategy.choose_action(50)).to eq(:attack)
      expect(strategy.choose_action(100)).to eq(:attack)
    end
  end

  describe '#name' do
    it 'returns strategy name' do
      expect(described_class.new.name).to eq('Balanced')
    end
  end
end

RSpec.describe Chapter05::GameCharacter do
  describe '#initialize' do
    it 'creates a character with name, health, and strategy' do
      strategy = Chapter05::AggressiveStrategy.new
      character = described_class.new('Warrior', 100, strategy)

      expect(character.name).to eq('Warrior')
      expect(character.health).to eq(100)
    end
  end

  describe '#take_turn' do
    it 'delegates action choice to strategy' do
      strategy = Chapter05::AggressiveStrategy.new
      character = described_class.new('Warrior', 100, strategy)

      expect(character.take_turn).to eq(:attack)
    end

    it 'uses defensive strategy when configured' do
      strategy = Chapter05::DefensiveStrategy.new
      character = described_class.new('Knight', 25, strategy)

      expect(character.take_turn).to eq(:defend)
    end

    it 'uses balanced strategy when configured' do
      strategy = Chapter05::BalancedStrategy.new
      character = described_class.new('Paladin', 40, strategy)

      expect(character.take_turn).to eq(:heal)
    end
  end

  describe '#change_strategy' do
    it 'allows changing strategy at runtime' do
      aggressive = Chapter05::AggressiveStrategy.new
      defensive = Chapter05::DefensiveStrategy.new
      character = described_class.new('Fighter', 20, aggressive)

      expect(character.take_turn).to eq(:attack)

      character.change_strategy(defensive)
      expect(character.take_turn).to eq(:defend)
    end
  end

  describe '#take_damage' do
    it 'reduces health by the damage amount' do
      strategy = Chapter05::AggressiveStrategy.new
      character = described_class.new('Warrior', 100, strategy)

      character.take_damage(30)

      expect(character.health).to eq(70)
    end

    it 'does not reduce health below zero' do
      strategy = Chapter05::AggressiveStrategy.new
      character = described_class.new('Warrior', 20, strategy)

      character.take_damage(50)

      expect(character.health).to eq(0)
    end
  end

  describe '#status' do
    it 'returns character status with strategy name' do
      strategy = Chapter05::BalancedStrategy.new
      character = described_class.new('Mage', 80, strategy)

      expect(character.status).to eq('Mage (HP: 80) using Balanced strategy')
    end
  end
end
