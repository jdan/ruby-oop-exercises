# frozen_string_literal: true

# Interface Segregation Principle (ISP)
#
# Clients should not be forced to depend on interfaces they do not use.
# Instead of one large interface, we use small, focused modules that
# classes can mix in selectively.
#
# RobotWorker only includes Workable - it doesn't need eat, take_break, or sleep.

# Workable module:
# - work - raises NotImplementedError (must be implemented by including class)

##
# Interface for entities that can perform work
module Workable
  def work
    raise NotImplementedError
  end
end

# Feedable module:
# - eat - raises NotImplementedError
# - take_break - raises NotImplementedError

##
# Interface for entities that need food and breaks
module Feedable
  def eat
    raise NotImplementedError
  end

  def take_break
    raise NotImplementedError
  end
end

# Sleepable module:
# - sleep - raises NotImplementedError

##
# Interface for entities that need rest
module Sleepable
  def sleep
    raise NotImplementedError
  end
end

# HumanWorker class:
# - includes Workable, Feedable, Sleepable
# - initialize(name)
# - name reader
# - work - returns "#{name} is working"
# - eat - returns "#{name} is eating lunch"
# - take_break - returns "#{name} is taking a break"
# - sleep - returns "#{name} is sleeping"

##
# A human employee with all capabilities
class HumanWorker
end

# RobotWorker class:
# - includes Workable only
# - initialize(model)
# - model reader
# - work - returns "Robot #{model} is working"
# - Does NOT have eat, take_break, or sleep

##
# A robot that only works (no breaks or sleep needed)
class RobotWorker
end

# ContractWorker class:
# - includes Workable, Feedable
# - initialize(name)
# - name reader
# - work - returns "#{name} (contractor) is working"
# - eat - returns "#{name} is eating"
# - take_break - returns "#{name} is on break"

##
# A contractor with work and break capabilities
class ContractWorker
end

# WorkScheduler class:
# - initialize(workers) - array of Workable objects
# - workers reader
# - assign_work - calls work on all workers, returns results array

##
# Schedules work for any Workable entity
class WorkScheduler
end

# BreakScheduler class:
# - initialize(workers) - array of workers
# - workers reader
# - feedable_workers - returns only Feedable workers
# - schedule_breaks - calls take_break on Feedable workers only

##
# Schedules breaks only for Feedable entities
class BreakScheduler
end
