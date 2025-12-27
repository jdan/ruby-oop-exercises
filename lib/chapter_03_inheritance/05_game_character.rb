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

##
# A character with a name and health
class Character
  attr_reader :name, :health

  def initialize(name, health)
    @name = name
    @health = health
  end

  def attack
    "#{name} attacks!"
  end

  def defend
    "#{name} defends!"
  end

  def take_damage(amount)
    @health -= amount
    @health = 0 if @health.negative?
  end

  def alive?
    @health.positive?
  end
end

##
# A warrior is a character with strength and a special move
class Warrior < Character
  attr_reader :strength

  def initialize(name, health, strength)
    super(name, health)
    @strength = strength
  end

  def attack
    "#{name} swings sword for #{strength} damage!"
  end

  def special_move
    "#{name} uses Shield Bash!"
  end
end

##
# A mage is a character with mana and a special move
class Mage < Character
  attr_reader :mana

  def initialize(name, health, mana)
    super(name, health)
    @mana = mana
  end

  def attack
    "#{name} casts fireball!"
  end

  def special_move
    return "#{name} is out of mana!" if @mana < 10

    @mana -= 10
    "#{name} casts Arcane Blast!"
  end
end
