# frozen_string_literal: true

require 'chapter_10_more_design_patterns/02_null_object'

RSpec.describe Chapter10::ConsoleLogger do
  let(:logger) { described_class.new }

  describe '#log' do
    it 'returns the logged message' do
      result = logger.log('Hello, World!')
      expect(result).to eq('[LOG] Hello, World!')
    end

    it 'formats different messages correctly' do
      expect(logger.log('Error occurred')).to eq('[LOG] Error occurred')
      expect(logger.log('User logged in')).to eq('[LOG] User logged in')
    end
  end

  describe '#warn' do
    it 'returns a warning message' do
      result = logger.warn('Disk space low')
      expect(result).to eq('[WARN] Disk space low')
    end
  end

  describe '#error' do
    it 'returns an error message' do
      result = logger.error('Connection failed')
      expect(result).to eq('[ERROR] Connection failed')
    end
  end
end

RSpec.describe Chapter10::NullLogger do
  let(:logger) { described_class.new }

  describe '#log' do
    it 'accepts a message and returns nil' do
      result = logger.log('Hello, World!')
      expect(result).to be_nil
    end

    it 'does not raise an error' do
      expect { logger.log('Any message') }.not_to raise_error
    end
  end

  describe '#warn' do
    it 'accepts a message and returns nil' do
      expect(logger.warn('Warning')).to be_nil
    end
  end

  describe '#error' do
    it 'accepts a message and returns nil' do
      expect(logger.error('Error')).to be_nil
    end
  end
end

RSpec.describe Chapter10::Application do
  describe '#initialize' do
    it 'accepts an optional logger' do
      logger = Chapter10::ConsoleLogger.new
      app = described_class.new(logger: logger)
      expect(app.logger).to eq(logger)
    end

    it 'defaults to NullLogger when no logger provided' do
      app = described_class.new
      expect(app.logger).to be_a(Chapter10::NullLogger)
    end
  end

  describe '#run' do
    it 'logs startup and completion messages with ConsoleLogger' do
      logger = Chapter10::ConsoleLogger.new
      app = described_class.new(logger: logger)

      allow(logger).to receive(:log).and_call_original

      app.run

      expect(logger).to have_received(:log).with('Application starting')
      expect(logger).to have_received(:log).with('Application finished')
    end

    it 'works without errors when using NullLogger' do
      app = described_class.new # Uses NullLogger by default

      expect { app.run }.not_to raise_error
    end

    it 'returns the result of the operation' do
      app = described_class.new
      expect(app.run).to eq('Operation complete')
    end
  end

  describe '#perform_operation' do
    it 'logs the operation being performed' do
      logger = Chapter10::ConsoleLogger.new
      app = described_class.new(logger: logger)

      allow(logger).to receive(:log).and_call_original

      app.perform_operation('backup')

      expect(logger).to have_received(:log).with('Performing operation: backup')
    end

    it 'returns the operation name' do
      app = described_class.new
      expect(app.perform_operation('sync')).to eq('sync')
    end
  end
end
