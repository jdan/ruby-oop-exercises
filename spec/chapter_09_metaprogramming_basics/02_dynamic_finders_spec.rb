# frozen_string_literal: true

require 'chapter_09_metaprogramming_basics/02_dynamic_finders'

RSpec.describe Chapter09::DynamicFinders do
  let(:test_class) do
    Class.new do
      include Chapter09::DynamicFinders

      attr_reader :records

      def initialize(records)
        @records = records
      end
    end
  end

  let(:records) do
    [
      { name: 'Alice', email: 'alice@example.com', role: 'admin' },
      { name: 'Bob', email: 'bob@example.com', role: 'user' },
      { name: 'Charlie', email: 'charlie@example.com', role: 'user' }
    ]
  end

  let(:repository) { test_class.new(records) }

  describe '#method_missing' do
    it 'handles find_by_* methods' do
      result = repository.find_by_name('Alice')
      expect(result).to eq({ name: 'Alice', email: 'alice@example.com', role: 'admin' })
    end

    it 'returns nil when no match is found' do
      result = repository.find_by_name('Unknown')
      expect(result).to be_nil
    end

    it 'raises NoMethodError for non-finder methods' do
      expect { repository.unknown_method }.to raise_error(NoMethodError)
    end

    it 'raises NoMethodError for methods not matching find_by_* pattern' do
      expect { repository.search_by_name('Alice') }.to raise_error(NoMethodError)
    end
  end

  describe '#respond_to_missing?' do
    it 'returns true for find_by_* methods' do
      expect(repository.respond_to?(:find_by_name)).to be true
      expect(repository.respond_to?(:find_by_email)).to be true
    end

    it 'returns false for unknown methods' do
      expect(repository.respond_to?(:unknown_method)).to be false
      expect(repository.respond_to?(:search_by_name)).to be false
    end
  end
end

RSpec.describe Chapter09::UserRepository do
  let(:users) do
    [
      { name: 'Alice', email: 'alice@example.com', department: 'Engineering' },
      { name: 'Bob', email: 'bob@example.com', department: 'Marketing' },
      { name: 'Charlie', email: 'charlie@example.com', department: 'Engineering' }
    ]
  end

  let(:repository) { described_class.new(users) }

  describe 'dynamic finders' do
    it 'finds by name' do
      result = repository.find_by_name('Bob')
      expect(result[:email]).to eq('bob@example.com')
    end

    it 'finds by email' do
      result = repository.find_by_email('charlie@example.com')
      expect(result[:name]).to eq('Charlie')
    end

    it 'finds by department' do
      result = repository.find_by_department('Marketing')
      expect(result[:name]).to eq('Bob')
    end

    it 'returns nil when not found' do
      result = repository.find_by_name('Unknown')
      expect(result).to be_nil
    end

    it 'responds to find_by_name' do
      expect(repository.respond_to?(:find_by_name)).to be true
    end

    it 'responds to find_by_email' do
      expect(repository.respond_to?(:find_by_email)).to be true
    end

    it 'does not respond to invalid methods' do
      expect(repository.respond_to?(:invalid_method)).to be false
    end
  end
end
