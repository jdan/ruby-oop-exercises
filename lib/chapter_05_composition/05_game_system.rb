# frozen_string_literal: true

# Implement the Strategy classes and GameCharacter here
#
# This exercise demonstrates the Strategy pattern via composition:
# GameCharacter delegates decision-making to an interchangeable strategy object.
#
# AggressiveStrategy class:
# - choose_action(current_health, enemy_health) always returns :attack
# - name method returns "Aggressive"
#
# DefensiveStrategy class:
# - choose_action(current_health, enemy_health) returns :defend if current_health < 30, else :attack
# - name method returns "Defensive"
#
# BalancedStrategy class:
# - choose_action(current_health, enemy_health) returns :heal if current_health < 50, else :attack
# - name method returns "Balanced"
#
# GameCharacter class:
# - initialize(name, health, strategy)
# - name reader
# - health reader
# - take_turn(enemy_health) delegates to strategy.choose_action(health, enemy_health)
# - change_strategy(new_strategy) swaps the strategy
# - take_damage(amount) reduces health (minimum 0)
# - status method returns "#{name} (HP: #{health}) using #{strategy.name} strategy"
