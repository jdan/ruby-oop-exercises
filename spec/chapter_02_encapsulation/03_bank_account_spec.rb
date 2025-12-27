# frozen_string_literal: true

require 'chapter_02_encapsulation/03_bank_account'

RSpec.describe BankAccount do
  describe '#initialize' do
    it 'creates an account with owner and default balance of 0' do
      account = BankAccount.new('Alice')
      expect(account.balance).to eq(0)
    end

    it 'can be created with a starting balance' do
      account = BankAccount.new('Bob', 100)
      expect(account.balance).to eq(100)
    end
  end

  describe '#balance' do
    it 'returns the current balance' do
      account = BankAccount.new('Alice', 50)
      expect(account.balance).to eq(50)
    end

    it 'cannot be set directly' do
      account = BankAccount.new('Alice', 50)
      expect { account.balance = 1000 }.to raise_error(NoMethodError)
    end
  end

  describe '#deposit' do
    it 'adds money to the balance' do
      account = BankAccount.new('Alice')
      account.deposit(50)
      expect(account.balance).to eq(50)
    end

    it 'can be called multiple times' do
      account = BankAccount.new('Alice')
      account.deposit(50)
      account.deposit(25)
      expect(account.balance).to eq(75)
    end
  end

  describe '#withdraw' do
    it 'removes money from the balance' do
      account = BankAccount.new('Alice', 100)
      account.withdraw(30)
      expect(account.balance).to eq(70)
    end

    it 'does not withdraw if insufficient funds' do
      account = BankAccount.new('Alice', 50)
      account.withdraw(100)
      expect(account.balance).to eq(50)
    end

    it 'returns true if withdrawal was successful' do
      account = BankAccount.new('Alice', 100)
      expect(account.withdraw(30)).to be true
    end

    it 'returns false if withdrawal failed' do
      account = BankAccount.new('Alice', 50)
      expect(account.withdraw(100)).to be false
    end
  end

  describe '#transaction_history' do
    it 'records deposits' do
      account = BankAccount.new('Alice')
      account.deposit(100)
      expect(account.transaction_history).to include('Deposit: 100')
    end

    it 'records withdrawals' do
      account = BankAccount.new('Alice', 100)
      account.withdraw(50)
      expect(account.transaction_history).to include('Withdrawal: 50')
    end

    it 'records multiple transactions in order' do
      account = BankAccount.new('Alice', 100)
      account.deposit(50)
      account.withdraw(25)
      history = account.transaction_history
      expect(history.length).to eq(2)
    end
  end

  describe 'private methods' do
    it 'has a private log_transaction method' do
      account = BankAccount.new('Alice')
      expect { account.log_transaction('test') }.to raise_error(NoMethodError)
    end
  end
end
