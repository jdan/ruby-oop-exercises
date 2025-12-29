# frozen_string_literal: true

# Implement the payment method classes and Checkout here
#
# This exercise demonstrates polymorphism: different payment methods
# share the same interface (process_payment, refund).
#
# CreditCard class:
# - initialize(card_number, cvv)
# - masked_number returns "****" + last 4 digits of card_number
# - process_payment(amount) returns "Charged $#{amount} to credit card #{masked_number}"
# - refund(amount) returns "Refunded $#{amount} to credit card #{masked_number}"
class CreditCard
  def initialize(card_number, cvv)
    @card_number = card_number
    @cvv = cvv
  end

  def masked_number
    "****#{@card_number[-4..]}"
  end

  def process_payment(amount)
    "Charged $#{amount} to credit card #{masked_number}"
  end

  def refund(amount)
    "Refunded $#{amount} to credit card #{masked_number}"
  end
end

#
# PayPal class:
# - initialize(email)
# - email reader
# - process_payment(amount) returns "PayPal payment of $#{amount} from #{email}"
# - refund(amount) returns "PayPal refund of $#{amount} to #{email}"
class PayPal
  attr_reader :email

  def initialize(email)
    @email = email
  end

  def process_payment(amount)
    "PayPal payment of $#{amount} from #{email}"
  end

  def refund(amount)
    "PayPal refund of $#{amount} to #{email}"
  end
end

#
# BankTransfer class:
# - initialize(account_number, routing_number)
# - masked_account returns "****" + last 4 digits of account_number
# - process_payment(amount) returns "Bank transfer of $#{amount} from account #{masked_account}"
# - refund(amount) returns "Bank transfer refund of $#{amount} to account #{masked_account}"
class BankTransfer
  def initialize(account_number, routing_number)
    @account_number = account_number
    @routing_number = routing_number
  end

  def masked_account
    "****#{@account_number[-4..]}"
  end

  def process_payment(amount)
    "Bank transfer of $#{amount} from account #{masked_account}"
  end

  def refund(amount)
    "Bank transfer refund of $#{amount} to account #{masked_account}"
  end
end

#
# Checkout class:
# - initialize(payment_method)
# - payment_method reader
# - complete_purchase(amount) delegates to payment_method.process_payment(amount)
# - process_refund(amount) delegates to payment_method.refund(amount)
# - change_payment_method(new_method) swaps the payment method
class Checkout
  attr_reader :payment_method

  def initialize(payment_method)
    @payment_method = payment_method
  end

  def complete_purchase(amount)
    @payment_method.process_payment(amount)
  end

  def process_refund(amount)
    @payment_method.refund(amount)
  end

  def change_payment_method(new_method)
    @payment_method = new_method
  end
end
