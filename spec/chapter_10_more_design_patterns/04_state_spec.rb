# frozen_string_literal: true

require 'chapter_10_more_design_patterns/04_state'

RSpec.describe Chapter10::Order do
  let(:order) { described_class.new }

  describe '#initialize' do
    it 'starts in pending state' do
      expect(order.status).to eq('pending')
    end
  end

  describe '#status' do
    it 'returns the current state name' do
      expect(order.status).to eq('pending')
    end
  end

  describe '#pay' do
    context 'when pending' do
      it 'transitions to paid state' do
        order.pay
        expect(order.status).to eq('paid')
      end

      it 'returns a success message' do
        expect(order.pay).to eq('Payment received')
      end
    end

    context 'when already paid' do
      before { order.pay }

      it 'returns an error message' do
        expect(order.pay).to eq('Order is already paid')
      end

      it 'stays in paid state' do
        order.pay
        expect(order.status).to eq('paid')
      end
    end

    context 'when shipped' do
      before do
        order.pay
        order.ship
      end

      it 'returns an error message' do
        expect(order.pay).to eq('Cannot pay for shipped order')
      end
    end
  end

  describe '#ship' do
    context 'when pending' do
      it 'returns an error message' do
        expect(order.ship).to eq('Cannot ship unpaid order')
      end

      it 'stays in pending state' do
        order.ship
        expect(order.status).to eq('pending')
      end
    end

    context 'when paid' do
      before { order.pay }

      it 'transitions to shipped state' do
        order.ship
        expect(order.status).to eq('shipped')
      end

      it 'returns a success message' do
        expect(order.ship).to eq('Order shipped')
      end
    end

    context 'when already shipped' do
      before do
        order.pay
        order.ship
      end

      it 'returns an error message' do
        expect(order.ship).to eq('Order is already shipped')
      end
    end
  end

  describe '#deliver' do
    context 'when pending' do
      it 'returns an error message' do
        expect(order.deliver).to eq('Cannot deliver unshipped order')
      end
    end

    context 'when paid but not shipped' do
      before { order.pay }

      it 'returns an error message' do
        expect(order.deliver).to eq('Cannot deliver unshipped order')
      end
    end

    context 'when shipped' do
      before do
        order.pay
        order.ship
      end

      it 'transitions to delivered state' do
        order.deliver
        expect(order.status).to eq('delivered')
      end

      it 'returns a success message' do
        expect(order.deliver).to eq('Order delivered')
      end
    end

    context 'when already delivered' do
      before do
        order.pay
        order.ship
        order.deliver
      end

      it 'returns an error message' do
        expect(order.deliver).to eq('Order is already delivered')
      end
    end
  end

  describe '#cancel' do
    context 'when pending' do
      it 'transitions to cancelled state' do
        order.cancel
        expect(order.status).to eq('cancelled')
      end

      it 'returns a success message' do
        expect(order.cancel).to eq('Order cancelled')
      end
    end

    context 'when paid' do
      before { order.pay }

      it 'transitions to cancelled state (refund initiated)' do
        order.cancel
        expect(order.status).to eq('cancelled')
      end

      it 'returns a refund message' do
        expect(order.cancel).to eq('Order cancelled, refund initiated')
      end
    end

    context 'when shipped' do
      before do
        order.pay
        order.ship
      end

      it 'returns an error message' do
        expect(order.cancel).to eq('Cannot cancel shipped order')
      end

      it 'stays in shipped state' do
        order.cancel
        expect(order.status).to eq('shipped')
      end
    end

    context 'when delivered' do
      before do
        order.pay
        order.ship
        order.deliver
      end

      it 'returns an error message' do
        expect(order.cancel).to eq('Cannot cancel delivered order')
      end
    end
  end
end

RSpec.describe 'State classes' do
  describe Chapter10::PendingState do
    it 'has status "pending"' do
      expect(described_class.new.status).to eq('pending')
    end
  end

  describe Chapter10::PaidState do
    it 'has status "paid"' do
      expect(described_class.new.status).to eq('paid')
    end
  end

  describe Chapter10::ShippedState do
    it 'has status "shipped"' do
      expect(described_class.new.status).to eq('shipped')
    end
  end

  describe Chapter10::DeliveredState do
    it 'has status "delivered"' do
      expect(described_class.new.status).to eq('delivered')
    end
  end

  describe Chapter10::CancelledState do
    it 'has status "cancelled"' do
      expect(described_class.new.status).to eq('cancelled')
    end
  end
end
