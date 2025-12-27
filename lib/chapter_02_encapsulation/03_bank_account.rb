# frozen_string_literal: true

# Implement the BankAccount class here
#
# A BankAccount should:
# - Be initialized with an owner name and optional starting balance (default 0)
# - Have a balance method that returns the current balance (read-only)
# - Have a deposit method that adds money to the balance
# - Have a withdraw method that removes money (if sufficient funds)
# - Have a transaction_history method that returns all transactions
# - Use a private log_transaction method to record each transaction

##
# A Bank acount which logs transactions
class BankAccount
  attr_reader :balance, :transaction_history

  def initialize(_owner, balance = 0)
    @balance = balance
    @transaction_history = []
  end

  def deposit(amount)
    @balance += amount
    log_transaction("Deposit: #{amount}")
  end

  def withdraw(amount)
    return false if @balance < amount

    @balance -= amount
    log_transaction("Withdrawal: #{amount}")
    true
  end

  private

  def log_transaction(log)
    @transaction_history << log
  end
end
