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
#
# PayPal class:
# - initialize(email)
# - email reader
# - process_payment(amount) returns "PayPal payment of $#{amount} from #{email}"
# - refund(amount) returns "PayPal refund of $#{amount} to #{email}"
#
# BankTransfer class:
# - initialize(account_number, routing_number)
# - masked_account returns "****" + last 4 digits of account_number
# - process_payment(amount) returns "Bank transfer of $#{amount} from account #{masked_account}"
# - refund(amount) returns "Bank transfer refund of $#{amount} to account #{masked_account}"
#
# Checkout class:
# - initialize(payment_method)
# - payment_method reader
# - complete_purchase(amount) delegates to payment_method.process_payment(amount)
# - process_refund(amount) delegates to payment_method.refund(amount)
# - change_payment_method(new_method) swaps the payment method
