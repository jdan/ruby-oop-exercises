# frozen_string_literal: true

require 'chapter_06_polymorphism_and_duck_typing/02_payment_processor'

RSpec.describe CreditCard do
  describe '#initialize' do
    it 'creates a credit card with number and cvv' do
      card = CreditCard.new('4111111111111111', '123')

      expect(card.masked_number).to eq('****1111')
    end
  end

  describe '#process_payment' do
    it 'returns success message with amount and masked number' do
      card = CreditCard.new('4111111111111111', '123')

      result = card.process_payment(99.99)

      expect(result).to eq('Charged $99.99 to credit card ****1111')
    end
  end

  describe '#refund' do
    it 'returns refund message' do
      card = CreditCard.new('4111111111111111', '123')

      result = card.refund(25.00)

      expect(result).to eq('Refunded $25.0 to credit card ****1111')
    end
  end
end

RSpec.describe PayPal do
  describe '#initialize' do
    it 'creates PayPal with email' do
      paypal = PayPal.new('user@example.com')

      expect(paypal.email).to eq('user@example.com')
    end
  end

  describe '#process_payment' do
    it 'returns success message with amount and email' do
      paypal = PayPal.new('user@example.com')

      result = paypal.process_payment(50.00)

      expect(result).to eq('PayPal payment of $50.0 from user@example.com')
    end
  end

  describe '#refund' do
    it 'returns refund message' do
      paypal = PayPal.new('user@example.com')

      result = paypal.refund(15.00)

      expect(result).to eq('PayPal refund of $15.0 to user@example.com')
    end
  end
end

RSpec.describe BankTransfer do
  describe '#initialize' do
    it 'creates bank transfer with account and routing numbers' do
      transfer = BankTransfer.new('12345678', '987654321')

      expect(transfer.masked_account).to eq('****5678')
    end
  end

  describe '#process_payment' do
    it 'returns success message with amount' do
      transfer = BankTransfer.new('12345678', '987654321')

      result = transfer.process_payment(200.00)

      expect(result).to eq('Bank transfer of $200.0 from account ****5678')
    end
  end

  describe '#refund' do
    it 'returns refund message' do
      transfer = BankTransfer.new('12345678', '987654321')

      result = transfer.refund(75.00)

      expect(result).to eq('Bank transfer refund of $75.0 to account ****5678')
    end
  end
end

RSpec.describe Checkout do
  describe '#initialize' do
    it 'creates checkout with a payment method' do
      card = CreditCard.new('4111111111111111', '123')
      checkout = Checkout.new(card)

      expect(checkout.payment_method).to eq(card)
    end
  end

  describe '#complete_purchase' do
    it 'processes payment through credit card' do
      card = CreditCard.new('4111111111111111', '123')
      checkout = Checkout.new(card)

      result = checkout.complete_purchase(99.99)

      expect(result).to eq('Charged $99.99 to credit card ****1111')
    end

    it 'processes payment through PayPal' do
      paypal = PayPal.new('user@example.com')
      checkout = Checkout.new(paypal)

      result = checkout.complete_purchase(50.00)

      expect(result).to eq('PayPal payment of $50.0 from user@example.com')
    end

    it 'processes payment through bank transfer' do
      transfer = BankTransfer.new('12345678', '987654321')
      checkout = Checkout.new(transfer)

      result = checkout.complete_purchase(200.00)

      expect(result).to eq('Bank transfer of $200.0 from account ****5678')
    end
  end

  describe '#process_refund' do
    it 'processes refund through any payment method' do
      paypal = PayPal.new('user@example.com')
      checkout = Checkout.new(paypal)

      result = checkout.process_refund(25.00)

      expect(result).to eq('PayPal refund of $25.0 to user@example.com')
    end
  end

  describe '#change_payment_method' do
    it 'allows switching payment methods' do
      card = CreditCard.new('4111111111111111', '123')
      paypal = PayPal.new('user@example.com')
      checkout = Checkout.new(card)

      checkout.change_payment_method(paypal)

      expect(checkout.complete_purchase(30.00)).to eq('PayPal payment of $30.0 from user@example.com')
    end
  end
end
