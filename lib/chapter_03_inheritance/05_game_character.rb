# frozen_string_literal: true

# Implement the GameCharacter class hierarchy here
#
# Character (base class):
# - initialize(name, health)
# - name, health readers
# - attack returns "#{name} attacks!"
# - defend returns "#{name} defends!"
# - take_damage(amount) reduces health by amount (min 0)
# - alive? returns true if health > 0
#
# Warrior (inherits from Character):
# - initialize(name, health, strength)
# - strength reader
# - attack returns "#{name} swings sword for #{strength} damage!"
# - special_move returns "#{name} uses Shield Bash!"
#
# Mage (inherits from Character):
# - initialize(name, health, mana)
# - mana reader
# - attack returns "#{name} casts fireball!"
# - special_move returns "#{name} casts Arcane Blast!" (costs 10 mana)
# - special_move returns "#{name} is out of mana!" if mana < 10

class Character
end

class Warrior < Character
end

class Mage < Character
end
