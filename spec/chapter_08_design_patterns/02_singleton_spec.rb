# frozen_string_literal: true

require 'chapter_08_design_patterns/02_singleton'

RSpec.describe Chapter08::Configuration do
  before do
    described_class.reset!
  end

  describe '.instance' do
    it 'returns a Configuration instance' do
      config = described_class.instance
      expect(config).to be_a(described_class)
    end

    it 'returns the same instance on multiple calls' do
      config1 = described_class.instance
      config2 = described_class.instance
      expect(config1).to be(config2)
    end

    it 'returns the same instance across different references' do
      config1 = described_class.instance
      config1.set(:app_name, 'MyApp')

      config2 = described_class.instance
      expect(config2.get(:app_name)).to eq('MyApp')
    end
  end

  describe '.new' do
    it 'raises NoMethodError when called directly' do
      expect { described_class.new }.to raise_error(NoMethodError)
    end
  end

  describe '#set' do
    it 'stores a configuration value' do
      config = described_class.instance
      config.set(:database_url, 'postgres://localhost/mydb')
      expect(config.get(:database_url)).to eq('postgres://localhost/mydb')
    end

    it 'overwrites existing values' do
      config = described_class.instance
      config.set(:port, 3000)
      config.set(:port, 8080)
      expect(config.get(:port)).to eq(8080)
    end
  end

  describe '#get' do
    it 'returns nil for unset keys' do
      config = described_class.instance
      expect(config.get(:nonexistent)).to be_nil
    end

    it 'returns the stored value for set keys' do
      config = described_class.instance
      config.set(:debug, true)
      expect(config.get(:debug)).to be true
    end
  end

  describe '.reset!' do
    it 'clears all configuration values' do
      config = described_class.instance
      config.set(:key1, 'value1')
      config.set(:key2, 'value2')

      described_class.reset!

      new_config = described_class.instance
      expect(new_config.get(:key1)).to be_nil
      expect(new_config.get(:key2)).to be_nil
    end

    it 'creates a new instance after reset' do
      old_config = described_class.instance
      described_class.reset!
      new_config = described_class.instance

      expect(new_config).not_to be(old_config)
    end
  end

  describe '#all' do
    it 'returns all configuration as a hash' do
      config = described_class.instance
      config.set(:host, 'localhost')
      config.set(:port, 3000)

      expect(config.all).to eq({ host: 'localhost', port: 3000 })
    end

    it 'returns an empty hash when no config is set' do
      config = described_class.instance
      expect(config.all).to eq({})
    end
  end
end
