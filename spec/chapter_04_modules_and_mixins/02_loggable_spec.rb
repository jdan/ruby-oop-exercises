# frozen_string_literal: true

require 'chapter_04_modules_and_mixins/02_loggable'

RSpec.describe Chapter04::Loggable do
  describe '#log' do
    it 'adds a timestamped message to the log history' do
      app = Chapter04::Application.new('TestApp')

      app.log('Test message')

      expect(app.log_history.size).to eq(1)
      expect(app.log_history.first).to match(/\[.*\] Test message/)
    end

    it 'adds multiple messages to the log history' do
      app = Chapter04::Application.new('TestApp')

      app.log('First')
      app.log('Second')

      expect(app.log_history.size).to eq(2)
    end
  end

  describe '#log_history' do
    it 'returns an empty array when no messages logged' do
      app = Chapter04::Application.new('TestApp')

      expect(app.log_history).to eq([])
    end

    it 'returns all logged messages in order' do
      app = Chapter04::Application.new('TestApp')

      app.log('One')
      app.log('Two')
      app.log('Three')

      expect(app.log_history.size).to eq(3)
      expect(app.log_history[0]).to match(/One/)
      expect(app.log_history[1]).to match(/Two/)
      expect(app.log_history[2]).to match(/Three/)
    end
  end
end

RSpec.describe Chapter04::Application do
  describe '#initialize' do
    it 'accepts a name' do
      app = described_class.new('MyApp')

      expect(app.name).to eq('MyApp')
    end
  end

  describe '#start' do
    it 'logs that the application started' do
      app = described_class.new('WebServer')

      app.start

      expect(app.log_history.last).to match(/Application WebServer started/)
    end
  end

  describe '#stop' do
    it 'logs that the application stopped' do
      app = described_class.new('WebServer')

      app.stop

      expect(app.log_history.last).to match(/Application WebServer stopped/)
    end
  end

  describe 'module inclusion' do
    it 'includes the Loggable module' do
      expect(described_class.included_modules).to include(Chapter04::Loggable)
    end
  end

  describe 'encapsulation' do
    it 'returns a copy from log_history so internal state cannot be mutated' do
      app = described_class.new('TestApp')
      app.log('original')

      app.log_history << '[INJECTED] sneaky message'

      expect(app.log_history.size).to eq(1)
    end

    it 'does not leak internal state from log' do
      app = described_class.new('TestApp')

      result = app.log('test message')

      expect(result).to be(app)
    end
  end
end
