# frozen_string_literal: true

require 'chapter_09_metaprogramming_basics/04_configurable'

RSpec.describe Chapter09::Configurable do
  let(:test_class) do
    Class.new do
      include Chapter09::Configurable
    end
  end

  after do
    test_class.reset_configuration if test_class.respond_to?(:reset_configuration)
  end

  describe '.configure' do
    it 'yields a configuration object' do
      test_class.configure do |config|
        expect(config).to be_a(Chapter09::Configuration)
      end
    end

    it 'allows setting arbitrary values' do
      test_class.configure do |config|
        config.app_name = 'TestApp'
        config.max_users = 100
      end

      expect(test_class.config.app_name).to eq('TestApp')
      expect(test_class.config.max_users).to eq(100)
    end
  end

  describe '.config' do
    it 'returns the configuration object' do
      expect(test_class.config).to be_a(Chapter09::Configuration)
    end

    it 'allows reading set values' do
      test_class.configure do |config|
        config.setting = 'value'
      end

      expect(test_class.config.setting).to eq('value')
    end

    it 'returns nil for unset values' do
      expect(test_class.config.unset_value).to be_nil
    end
  end
end

RSpec.describe Chapter09::Configuration do
  let(:config) { described_class.new }

  describe 'dynamic settings' do
    it 'stores arbitrary settings' do
      config.name = 'MyApp'
      expect(config.name).to eq('MyApp')
    end

    it 'returns nil for unset settings' do
      expect(config.unknown_setting).to be_nil
    end

    it 'allows overwriting settings' do
      config.value = 'first'
      config.value = 'second'
      expect(config.value).to eq('second')
    end
  end
end

RSpec.describe Chapter09::AppSettings do
  before { described_class.reset_configuration }

  describe 'configuration' do
    it 'stores simple settings' do
      described_class.configure do |config|
        config.app_name = 'MyApp'
        config.version = '1.0.0'
      end

      expect(described_class.config.app_name).to eq('MyApp')
      expect(described_class.config.version).to eq('1.0.0')
    end

    it 'stores numeric settings' do
      described_class.configure do |config|
        config.max_connections = 10
        config.timeout = 30
      end

      expect(described_class.config.max_connections).to eq(10)
      expect(described_class.config.timeout).to eq(30)
    end

    it 'allows reading settings back' do
      described_class.configure do |config|
        config.debug = true
      end

      expect(described_class.config.debug).to be true
    end

    it 'persists settings across multiple accesses' do
      described_class.configure do |config|
        config.persistent = 'value'
      end

      expect(described_class.config.persistent).to eq('value')
      expect(described_class.config.persistent).to eq('value')
    end
  end
end
