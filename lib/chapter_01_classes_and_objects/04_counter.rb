# frozen_string_literal: true

# Implement the Counter class here
#
# A Counter should:
# - Be initialized with an optional start value (default 0)
# - Have a value method that returns the current count
# - Have an increment method that increases count by 1
# - Have a decrement method that decreases count by 1
# - Have a reset method that sets count back to the initial value

module Chapter01
  ##
  # A counter which tracks its state
  class Counter
    # attr_reader gives us a `value` getter method
    # but tightly couples the instance variable name
    attr_reader :value

    def initialize(start_value = 0)
      @start_value = start_value
      @value = start_value
    end

    def increment
      @value += 1
    end

    def decrement
      @value -= 1
    end

    def reset
      @value = @start_value
    end
  end
end
