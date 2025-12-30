# frozen_string_literal: true

require 'chapter_10_more_design_patterns/03_adapter'

RSpec.describe Chapter10::ModernPaymentGateway do
  let(:gateway) { described_class.new }

  describe '#process_payment' do
    it 'processes a payment and returns a success hash' do
      result = gateway.process_payment(amount: 99.99, currency: 'USD')

      expect(result).to be_a(Hash)
      expect(result[:success]).to be true
      expect(result[:amount]).to eq(99.99)
      expect(result[:currency]).to eq('USD')
    end

    it 'includes a transaction ID' do
      result = gateway.process_payment(amount: 50.00, currency: 'EUR')

      expect(result[:transaction_id]).to be_a(String)
      expect(result[:transaction_id]).not_to be_empty
    end

    it 'handles different amounts and currencies' do
      result = gateway.process_payment(amount: 1000.00, currency: 'GBP')

      expect(result[:amount]).to eq(1000.00)
      expect(result[:currency]).to eq('GBP')
    end
  end
end

RSpec.describe Chapter10::LegacyPaymentSystem do
  let(:system) { described_class.new }

  describe '#charge' do
    it 'charges with dollars and cents as separate arguments' do
      result = system.charge(99, 99)

      expect(result).to be_a(String)
      expect(result).to include('99')
      expect(result).to include('charged')
    end

    it 'returns a confirmation string' do
      result = system.charge(50, 0)

      expect(result).to eq('Charged $50.00 successfully')
    end

    it 'formats cents correctly' do
      expect(system.charge(10, 5)).to eq('Charged $10.05 successfully')
      expect(system.charge(0, 99)).to eq('Charged $0.99 successfully')
    end
  end
end

RSpec.describe Chapter10::LegacyPaymentAdapter do
  let(:legacy_system) { Chapter10::LegacyPaymentSystem.new }
  let(:adapter) { described_class.new(legacy_system) }

  describe '#initialize' do
    it 'wraps a legacy payment system' do
      expect(adapter.legacy_system).to eq(legacy_system)
    end
  end

  describe '#process_payment' do
    it 'adapts the modern interface to the legacy system' do
      result = adapter.process_payment(amount: 99.99, currency: 'USD')

      expect(result).to be_a(Hash)
      expect(result[:success]).to be true
    end

    it 'converts decimal amount to dollars and cents' do
      allow(legacy_system).to receive(:charge).and_call_original

      adapter.process_payment(amount: 123.45, currency: 'USD')

      expect(legacy_system).to have_received(:charge).with(123, 45)
    end

    it 'handles whole dollar amounts' do
      allow(legacy_system).to receive(:charge).and_call_original

      adapter.process_payment(amount: 50.00, currency: 'USD')

      expect(legacy_system).to have_received(:charge).with(50, 0)
    end

    it 'returns the legacy confirmation in the response' do
      result = adapter.process_payment(amount: 75.50, currency: 'USD')

      expect(result[:legacy_confirmation]).to eq('Charged $75.50 successfully')
    end

    it 'ignores currency since legacy system only supports USD' do
      result = adapter.process_payment(amount: 100.00, currency: 'EUR')

      # Still processes, but legacy system only does USD
      expect(result[:success]).to be true
      expect(result[:currency]).to eq('EUR')
      expect(result[:note]).to include('USD')
    end
  end
end

RSpec.describe 'Payment System Integration' do
  # Both ModernPaymentGateway and LegacyPaymentAdapter respond to process_payment
  # This demonstrates the Adapter pattern making incompatible interfaces compatible

  let(:modern_gateway) { Chapter10::ModernPaymentGateway.new }
  let(:legacy_system) { Chapter10::LegacyPaymentSystem.new }
  let(:adapted_legacy) { Chapter10::LegacyPaymentAdapter.new(legacy_system) }

  it 'allows both gateways to be used interchangeably' do
    gateways = [modern_gateway, adapted_legacy]

    gateways.each do |gateway|
      result = gateway.process_payment(amount: 50.00, currency: 'USD')

      expect(result[:success]).to be true
      expect(result[:amount]).to eq(50.00)
    end
  end
end
