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
    def process_payment(amount:, currency:)
      {
        success: true,
        amount: amount,
        currency: currency,
        transaction_id: 'abc123'
      }
    end
  end

  ##
  # Legacy payment system with positional argument interface
  #    - charge(dollars, cents) - takes two integers
  #      returns "Charged $X.XX successfully" (format cents with leading zero if needed)
  class LegacyPaymentSystem
    def charge(dollars, cents)
      "Charged $#{dollars}.#{cents.to_s.rjust(2, '0')} successfully"
    end
  end

  ##
  # Adapter that makes LegacyPaymentSystem work with modern interface
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
  class LegacyPaymentAdapter
    attr_reader :legacy_system

    def initialize(legacy_system)
      @legacy_system = legacy_system
    end

    def process_payment(amount:, currency:)
      dollars = amount.to_i
      cents = ((amount % 1) * 100).round

      confirmation = legacy_system.charge(dollars, cents)
      {
        success: true,
        amount: amount,
        currency: currency,
        legacy_confirmation: confirmation,
        note: 'Processed via legacy system (USD only)'
      }
    end
  end
end
