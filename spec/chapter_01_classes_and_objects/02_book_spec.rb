# frozen_string_literal: true

require 'chapter_01_classes_and_objects/02_book'

RSpec.describe Chapter01::Book do
  describe '#initialize' do
    it 'creates a book with title, author, and pages' do
      book = described_class.new('1984', 'George Orwell', 328)
      expect(book).to be_a(described_class)
    end
  end

  describe '#summary' do
    it 'returns title by author' do
      book = described_class.new('1984', 'George Orwell', 328)
      expect(book.summary).to eq('1984 by George Orwell')
    end

    it 'works with different books' do
      book = described_class.new('The Hobbit', 'J.R.R. Tolkien', 310)
      expect(book.summary).to eq('The Hobbit by J.R.R. Tolkien')
    end
  end

  describe '#long_read?' do
    it 'returns true for books over 300 pages' do
      book = described_class.new('War and Peace', 'Leo Tolstoy', 1225)
      expect(book.long_read?).to be true
    end

    it 'returns false for books with 300 or fewer pages' do
      book = described_class.new('The Old Man and the Sea', 'Ernest Hemingway', 127)
      expect(book.long_read?).to be false
    end

    it 'returns false for exactly 300 pages' do
      book = described_class.new('Some Book', 'Some Author', 300)
      expect(book.long_read?).to be false
    end
  end
end
