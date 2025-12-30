# frozen_string_literal: true

# Chapter 10: More Design Patterns
# Exercise 04: State Pattern
#
# The State pattern allows an object to alter its behavior when its internal
# state changes. The object will appear to change its class.
#
# Scenario: An Order that progresses through states: pending -> paid -> shipped -> delivered
# Each state has different rules about what operations are valid.
#
# Implement the following:
#
# 1. State classes (each with a status method returning the state name):
#    - PendingState
#    - PaidState
#    - ShippedState
#    - DeliveredState
#    - CancelledState
#
#    Each state class should implement:
#    - status - returns state name as string ('pending', 'paid', etc.)
#    - pay(order) - handle payment attempt
#    - ship(order) - handle ship attempt
#    - deliver(order) - handle delivery attempt
#    - cancel(order) - handle cancellation attempt
#
# 2. Order class
#    - initialize - starts in PendingState
#    - status - delegates to current state's status method
#    - pay - delegates to current state
#    - ship - delegates to current state
#    - deliver - delegates to current state
#    - cancel - delegates to current state
#    - transition_to(state) - changes the current state (used by state classes)
#
# State transition rules:
#   pending: can pay -> paid, can cancel -> cancelled
#   paid: can ship -> shipped, can cancel -> cancelled (with refund)
#   shipped: can deliver -> delivered, cannot cancel
#   delivered: final state, no more transitions
#   cancelled: final state, no more transitions
#
# Return messages from state methods (see specs for exact wording)

module Chapter10
  ##
  # Base class or module for order states (optional, for shared behavior)
  # You may choose to use inheritance, modules, or neither

  ##
  # Order is pending, waiting for payment
  class PendingState
    # TODO: Implement status, pay, ship, deliver, cancel
  end

  ##
  # Order has been paid
  class PaidState
    # TODO: Implement status, pay, ship, deliver, cancel
  end

  ##
  # Order has been shipped
  class ShippedState
    # TODO: Implement status, pay, ship, deliver, cancel
  end

  ##
  # Order has been delivered
  class DeliveredState
    # TODO: Implement status, pay, ship, deliver, cancel
  end

  ##
  # Order has been cancelled
  class CancelledState
    # TODO: Implement status, pay, ship, deliver, cancel
  end

  ##
  # An order that changes behavior based on its current state
  class Order
    # TODO: Implement initialize, status, pay, ship, deliver, cancel, transition_to
  end
end
