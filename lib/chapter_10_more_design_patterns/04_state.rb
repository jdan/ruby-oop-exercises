# frozen_string_literal: true

# Chapter 10: More Design Patterns
# Exercise 04: State Pattern

module Chapter10
  # Order is pending, waiting for payment
  class PendingState
    def status
      'pending'
    end

    def pay(order)
      order.transition_to(PaidState.new)
      'Payment received'
    end

    def ship(_order)
      'Cannot ship unpaid order'
    end

    def deliver(_order)
      'Cannot deliver unshipped order'
    end

    def cancel(order)
      order.transition_to(CancelledState.new)
      'Order cancelled'
    end
  end

  # Order has been paid
  class PaidState
    def status
      'paid'
    end

    def pay(_order)
      'Order is already paid'
    end

    def ship(order)
      order.transition_to(ShippedState.new)
      'Order shipped'
    end

    def deliver(_order)
      'Cannot deliver unshipped order'
    end

    def cancel(order)
      order.transition_to(CancelledState.new)
      'Order cancelled, refund initiated'
    end
  end

  # Order has been shipped
  class ShippedState
    def status
      'shipped'
    end

    def pay(_order)
      'Cannot pay for shipped order'
    end

    def ship(_order)
      'Order is already shipped'
    end

    def deliver(order)
      order.transition_to(DeliveredState.new)
      'Order delivered'
    end

    def cancel(_order)
      'Cannot cancel shipped order'
    end
  end

  # Order has been delivered
  class DeliveredState
    def status
      'delivered'
    end

    def pay(_order)
      'Cannot pay for delivered order'
    end

    def ship(_order)
      'Cannot ship delivered order'
    end

    def deliver(_order)
      'Order is already delivered'
    end

    def cancel(_order)
      'Cannot cancel delivered order'
    end
  end

  # Order has been cancelled
  class CancelledState
    def status
      'cancelled'
    end

    def pay(_order)
      'Cannot pay for cancelled order'
    end

    def ship(_order)
      'Cannot ship cancelled order'
    end

    def deliver(_order)
      'Cannot deliver cancelled order'
    end

    def cancel(_order)
      'Order is already cancelled'
    end
  end

  # An order that changes behavior based on its current state
  class Order
    def initialize
      @state = PendingState.new
    end

    def status
      @state.status
    end

    def pay
      @state.pay(self)
    end

    def ship
      @state.ship(self)
    end

    def deliver
      @state.deliver(self)
    end

    def cancel
      @state.cancel(self)
    end

    def transition_to(new_state)
      @state = new_state
    end
  end
end
