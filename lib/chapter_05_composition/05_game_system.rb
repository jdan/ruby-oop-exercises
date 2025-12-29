# frozen_string_literal: true

# Implement the Strategy classes and GameCharacter here
#
# This exercise demonstrates the Strategy pattern via composition:
# GameCharacter delegates decision-making to an interchangeable strategy object.
#
# AggressiveStrategy class:
# - choose_action(current_health, enemy_health) always returns :attack
# - name method returns "Aggressive"
module Chapter05
  AggressiveStrategy = Struct.new do
    def choose_action(*)
      :attack
    end

    def name = 'Aggressive'
  end

  #
  # DefensiveStrategy class:
  # - choose_action(current_health, enemy_health) returns :defend if current_health < 30, else :attack
  # - name method returns "Defensive"
  DefensiveStrategy = Struct.new do
    def choose_action(current_health)
      if current_health < 30
        :defend
      else
        :attack
      end
    end

    def name = 'Defensive'
  end

  #
  # BalancedStrategy class:
  # - choose_action(current_health, enemy_health) returns :heal if current_health < 50, else :attack
  # - name method returns "Balanced"
  BalancedStrategy = Struct.new do
    def choose_action(current_health)
      if current_health < 50
        :heal
      else
        :attack
      end
    end

    def name = 'Balanced'
  end

  #
  # GameCharacter class:
  # - initialize(name, health, strategy)
  # - name reader
  # - health reader
  # - take_turn(enemy_health) delegates to strategy.choose_action(health, enemy_health)
  # - change_strategy(new_strategy) swaps the strategy
  # - take_damage(amount) reduces health (minimum 0)
  # - status method returns "#{name} (HP: #{health}) using #{strategy.name} strategy"
  class GameCharacter
    attr_accessor :name, :health

    def initialize(name, health, strategy)
      @name = name
      @health = health
      @strategy = strategy
    end

    def take_turn
      @strategy.choose_action(@health)
    end

    def change_strategy(new_strategy)
      @strategy = new_strategy
    end

    def take_damage(amount)
      @health -= amount
      @health = 0 if @health.negative?
    end

    def status
      "#{name} (HP: #{health}) using #{@strategy.name} strategy"
    end
  end
end
