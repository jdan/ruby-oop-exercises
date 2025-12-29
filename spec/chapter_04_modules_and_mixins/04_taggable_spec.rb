# frozen_string_literal: true

require 'chapter_04_modules_and_mixins/04_taggable'

RSpec.describe Chapter04::Taggable do
  describe '#add_tag' do
    it 'adds a tag' do
      article = Chapter04::Article.new('Ruby Tips')

      article.add_tag('ruby')

      expect(article.tags).to include('ruby')
    end

    it 'does not add duplicate tags' do
      article = Chapter04::Article.new('Ruby Tips')

      article.add_tag('ruby')
      article.add_tag('ruby')

      expect(article.tags.count('ruby')).to eq(1)
    end
  end

  describe '#remove_tag' do
    it 'removes a tag' do
      article = Chapter04::Article.new('Ruby Tips')
      article.add_tag('ruby')
      article.add_tag('programming')

      article.remove_tag('ruby')

      expect(article.tags).not_to include('ruby')
      expect(article.tags).to include('programming')
    end
  end

  describe '#tags' do
    it 'returns an empty array initially' do
      article = Chapter04::Article.new('Empty Article')

      expect(article.tags).to eq([])
    end

    it 'returns all tags' do
      article = Chapter04::Article.new('Tagged Article')
      article.add_tag('tech')
      article.add_tag('news')

      expect(article.tags).to contain_exactly('tech', 'news')
    end
  end

  describe '#tagged_with?' do
    it 'returns true if the tag exists' do
      article = Chapter04::Article.new('Test')
      article.add_tag('important')

      expect(article.tagged_with?('important')).to be true
    end

    it 'returns false if the tag does not exist' do
      article = Chapter04::Article.new('Test')

      expect(article.tagged_with?('missing')).to be false
    end
  end

  describe '#clear_tags' do
    it 'removes all tags' do
      article = Chapter04::Article.new('Test')
      article.add_tag('one')
      article.add_tag('two')
      article.add_tag('three')

      article.clear_tags

      expect(article.tags).to eq([])
    end
  end

  describe 'encapsulation' do
    it 'does not expose tag_set publicly' do
      article = Chapter04::Article.new('Test')

      expect { article.tag_set }.to raise_error(NoMethodError, /private method/)
    end

    it 'returns a copy from tags so internal state cannot be mutated' do
      article = Chapter04::Article.new('Test')
      article.add_tag('original')

      article.tags << 'injected'

      expect(article.tags).to eq(['original'])
    end

    it 'does not leak internal state from add_tag' do
      article = Chapter04::Article.new('Test')

      result = article.add_tag('ruby')

      expect(result).to be(article)
    end

    it 'does not leak internal state from remove_tag' do
      article = Chapter04::Article.new('Test')
      article.add_tag('ruby')

      result = article.remove_tag('ruby')

      expect(result).to be(article)
    end

    it 'does not leak internal state from clear_tags' do
      article = Chapter04::Article.new('Test')
      article.add_tag('ruby')

      result = article.clear_tags

      expect(result).to be(article)
    end
  end
end

RSpec.describe Chapter04::Article do
  describe '#initialize' do
    it 'accepts a title' do
      article = described_class.new('My Article')

      expect(article.title).to eq('My Article')
    end
  end

  describe 'module inclusion' do
    it 'includes the Taggable module' do
      expect(described_class.included_modules).to include(Chapter04::Taggable)
    end
  end
end

RSpec.describe Chapter04::Photo do
  describe '#initialize' do
    it 'accepts a filename' do
      photo = described_class.new('sunset.jpg')

      expect(photo.filename).to eq('sunset.jpg')
    end
  end

  describe 'module inclusion' do
    it 'includes the Taggable module' do
      expect(described_class.included_modules).to include(Chapter04::Taggable)
    end

    it 'can use tagging functionality' do
      photo = described_class.new('beach.png')
      photo.add_tag('vacation')
      photo.add_tag('summer')

      expect(photo.tags).to contain_exactly('vacation', 'summer')
    end
  end
end
