# frozen_string_literal: true

require 'chapter_09_metaprogramming_basics/03_method_delegation'

RSpec.describe Chapter09::Delegatable do
  describe '.delegate' do
    let(:target_class) do
      Class.new do
        attr_accessor :value, :count

        def initialize
          @value = 'target_value'
          @count = 42
        end
      end
    end

    context 'without prefix' do
      let(:delegating_class) do
        target = target_class
        Class.new do
          include Chapter09::Delegatable

          attr_reader :target

          delegate :value, :count, to: :target

          define_method(:initialize) do
            @target = target.new
          end
        end
      end

      it 'creates a method that forwards to the target' do
        obj = delegating_class.new
        expect(obj.value).to eq('target_value')
      end

      it 'handles multiple methods in one call' do
        obj = delegating_class.new
        expect(obj.value).to eq('target_value')
        expect(obj.count).to eq(42)
      end
    end

    context 'with prefix option' do
      let(:delegating_class) do
        target = target_class
        Class.new do
          include Chapter09::Delegatable

          attr_reader :source

          delegate :value, :count, to: :source, prefix: true

          define_method(:initialize) do
            @source = target.new
          end
        end
      end

      it 'creates prefixed method names' do
        obj = delegating_class.new
        expect(obj.source_value).to eq('target_value')
        expect(obj.source_count).to eq(42)
      end

      it 'does not create unprefixed methods' do
        obj = delegating_class.new
        expect(obj.respond_to?(:value)).to be false
      end
    end
  end
end

RSpec.describe Chapter09::Author do
  it 'has a name attribute' do
    author = described_class.new('George Orwell')
    expect(author.name).to eq('George Orwell')
  end
end

RSpec.describe Chapter09::Book do
  let(:author) { Chapter09::Author.new('George Orwell') }
  let(:book) { described_class.new('1984', author) }

  describe '#title' do
    it 'returns the book title' do
      expect(book.title).to eq('1984')
    end
  end

  describe '#author' do
    it 'returns the author object' do
      expect(book.author).to eq(author)
    end
  end

  describe '#author_name' do
    it 'delegates to author.name' do
      expect(book.author_name).to eq('George Orwell')
    end
  end

  describe 'delegation' do
    it 'responds to author_name' do
      expect(book.respond_to?(:author_name)).to be true
    end
  end
end
