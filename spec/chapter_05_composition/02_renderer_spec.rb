# frozen_string_literal: true

require 'chapter_05_composition/02_renderer'

RSpec.describe Chapter05::HtmlRenderer do
  describe '#render' do
    it 'wraps content in HTML tags' do
      renderer = described_class.new
      expect(renderer.render('Hello')).to eq('<html><body>Hello</body></html>')
    end
  end
end

RSpec.describe Chapter05::MarkdownRenderer do
  describe '#render' do
    it 'returns content as-is with markdown header' do
      renderer = described_class.new
      expect(renderer.render('Hello')).to eq("# Document\n\nHello")
    end
  end
end

RSpec.describe Chapter05::PlainTextRenderer do
  describe '#render' do
    it 'returns content as-is' do
      renderer = described_class.new
      expect(renderer.render('Hello')).to eq('Hello')
    end
  end
end

RSpec.describe Chapter05::Document do
  describe '#initialize' do
    it 'creates a document with content and a renderer' do
      renderer = Chapter05::PlainTextRenderer.new
      doc = described_class.new('My content', renderer)

      expect(doc.content).to eq('My content')
    end
  end

  describe '#render' do
    it 'delegates rendering to the injected renderer' do
      html_renderer = Chapter05::HtmlRenderer.new
      doc = described_class.new('Hello World', html_renderer)

      expect(doc.render).to eq('<html><body>Hello World</body></html>')
    end

    it 'can use different renderers via dependency injection' do
      markdown_renderer = Chapter05::MarkdownRenderer.new
      doc = described_class.new('Hello World', markdown_renderer)

      expect(doc.render).to eq("# Document\n\nHello World")
    end

    it 'works with plain text renderer' do
      plain_renderer = Chapter05::PlainTextRenderer.new
      doc = described_class.new('Hello World', plain_renderer)

      expect(doc.render).to eq('Hello World')
    end
  end

  describe '#change_renderer' do
    it 'allows changing the renderer at runtime' do
      html_renderer = Chapter05::HtmlRenderer.new
      markdown_renderer = Chapter05::MarkdownRenderer.new
      doc = described_class.new('Content', html_renderer)

      expect(doc.render).to eq('<html><body>Content</body></html>')

      doc.change_renderer(markdown_renderer)
      expect(doc.render).to eq("# Document\n\nContent")
    end
  end
end
