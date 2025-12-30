# frozen_string_literal: true

require 'chapter_08_design_patterns/03_observer'

RSpec.describe Chapter08::EventEmitter do
  let(:emitter_class) do
    Class.new do
      include Chapter08::EventEmitter
    end
  end

  let(:emitter) { emitter_class.new }

  describe '#subscribe' do
    it 'registers a callback for an event' do
      called = false
      emitter.subscribe(:test) { called = true }
      emitter.emit(:test)
      expect(called).to be true
    end

    it 'can register multiple callbacks for the same event' do
      results = []
      emitter.subscribe(:test) { results << 1 }
      emitter.subscribe(:test) { results << 2 }
      emitter.emit(:test)
      expect(results).to eq([1, 2])
    end
  end

  describe '#unsubscribe' do
    it 'removes a callback from an event' do
      called = false
      callback = proc { called = true }
      emitter.subscribe(:test, &callback)
      emitter.unsubscribe(:test, &callback)
      emitter.emit(:test)
      expect(called).to be false
    end

    it 'only removes the specified callback' do
      results = []
      callback1 = proc { results << 1 }
      callback2 = proc { results << 2 }
      emitter.subscribe(:test, &callback1)
      emitter.subscribe(:test, &callback2)
      emitter.unsubscribe(:test, &callback1)
      emitter.emit(:test)
      expect(results).to eq([2])
    end
  end

  describe '#emit' do
    it 'calls all registered callbacks for an event' do
      results = []
      emitter.subscribe(:data) { results << 'a' }
      emitter.subscribe(:data) { results << 'b' }
      emitter.emit(:data)
      expect(results).to eq(%w[a b])
    end

    it 'passes arguments to callbacks' do
      received = nil
      emitter.subscribe(:message) { |msg| received = msg }
      emitter.emit(:message, 'Hello!')
      expect(received).to eq('Hello!')
    end

    it 'passes multiple arguments to callbacks' do
      received = nil
      emitter.subscribe(:coords) { |x, y| received = [x, y] }
      emitter.emit(:coords, 10, 20)
      expect(received).to eq([10, 20])
    end

    it 'does nothing when no callbacks are registered' do
      expect { emitter.emit(:unknown) }.not_to raise_error
    end

    it 'only triggers callbacks for the specified event' do
      results = []
      emitter.subscribe(:event1) { results << 1 }
      emitter.subscribe(:event2) { results << 2 }
      emitter.emit(:event1)
      expect(results).to eq([1])
    end
  end
end

RSpec.describe Chapter08::NewsPublisher do
  describe '#initialize' do
    it 'creates a publisher with a name' do
      publisher = described_class.new('Tech News')
      expect(publisher.name).to eq('Tech News')
    end
  end

  describe '#publish' do
    it 'emits a news event with the article' do
      publisher = described_class.new('Daily News')
      received = nil
      publisher.subscribe(:news) { |article| received = article }
      publisher.publish('Breaking: Ruby 4.0 Released!')
      expect(received).to eq('Breaking: Ruby 4.0 Released!')
    end

    it 'notifies multiple subscribers' do
      publisher = described_class.new('Sports News')
      results = []
      publisher.subscribe(:news) { |article| results << "Sub1: #{article}" }
      publisher.subscribe(:news) { |article| results << "Sub2: #{article}" }
      publisher.publish('Team wins championship!')
      expect(results).to eq(['Sub1: Team wins championship!', 'Sub2: Team wins championship!'])
    end
  end
end

RSpec.describe Chapter08::NewsSubscriber do
  describe '#initialize' do
    it 'creates a subscriber with a name' do
      subscriber = described_class.new('Alice')
      expect(subscriber.name).to eq('Alice')
    end

    it 'starts with no received articles' do
      subscriber = described_class.new('Bob')
      expect(subscriber.received_articles).to eq([])
    end
  end

  describe '#follow' do
    it 'subscribes to a publisher' do
      publisher = Chapter08::NewsPublisher.new('Tech')
      subscriber = described_class.new('Charlie')

      subscriber.follow(publisher)
      publisher.publish('New article!')

      expect(subscriber.received_articles).to include('New article!')
    end
  end

  describe '#unfollow' do
    it 'unsubscribes from a publisher' do
      publisher = Chapter08::NewsPublisher.new('Tech')
      subscriber = described_class.new('Dave')

      subscriber.follow(publisher)
      subscriber.unfollow(publisher)
      publisher.publish('Missed article')

      expect(subscriber.received_articles).to eq([])
    end
  end

  describe '#received_articles' do
    it 'returns all received articles in order' do
      publisher = Chapter08::NewsPublisher.new('News')
      subscriber = described_class.new('Eve')

      subscriber.follow(publisher)
      publisher.publish('First')
      publisher.publish('Second')
      publisher.publish('Third')

      expect(subscriber.received_articles).to eq(%w[First Second Third])
    end
  end
end
