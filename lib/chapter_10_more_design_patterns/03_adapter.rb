# frozen_string_literal: true

# Chapter 10: More Design Patterns
# Exercise 03: Adapter Pattern
#
# The Adapter pattern allows objects with incompatible interfaces to work
# together. It wraps an object and translates calls to its interface.
#
# Scenario: You have a modern payment system interface, but need to integrate
# with a legacy payment system that has a different API.
#
# Implement the following:
#
# 1. ModernPaymentGateway class
#    - process_payment(amount:, currency:) - returns a hash:
#      {
#        success: true,
#        amount: amount,
#        currency: currency,
#        transaction_id: <unique string>
#      }
#
# 2. LegacyPaymentSystem class
#    - charge(dollars, cents) - takes two integers
#      returns "Charged $X.XX successfully" (format cents with leading zero if needed)
#
# 3. LegacyPaymentAdapter class
#    - initialize(legacy_system) - wraps the legacy system
#    - legacy_system - attr_reader
#    - process_payment(amount:, currency:) - adapts the modern interface to legacy
#      - Converts amount (float) to dollars and cents integers
#      - Calls legacy_system.charge(dollars, cents)
#      - Returns hash with:
#        {
#          success: true,
#          amount: amount,
#          currency: currency,
#          legacy_confirmation: <result from charge>,
#          note: "Processed via legacy system (USD only)"
#        }
#
# Hint: To split 99.99 into dollars and cents:
#   dollars = amount.to_i          # => 99
#   cents = ((amount % 1) * 100).round  # => 99

module Chapter10
  ##
  # Modern payment gateway with keyword argument interface
  class ModernPaymentGateway
    # TODO: Implement process_payment(amount:, currency:)
  end

  ##
  # Legacy payment system with positional argument interface
  class LegacyPaymentSystem
    # TODO: Implement charge(dollars, cents)
  end

  ##
  # Adapter that makes LegacyPaymentSystem work with modern interface
  class LegacyPaymentAdapter
    # TODO: Implement initialize, legacy_system, and process_payment
  end
end
