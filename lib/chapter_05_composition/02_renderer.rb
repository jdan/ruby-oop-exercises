# frozen_string_literal: true

# Implement the Renderer classes and Document class here
#
# This exercise demonstrates dependency injection: Document accepts
# a renderer as a dependency, making it flexible and testable.
#
# HtmlRenderer class:
# - render(content) returns "<html><body>#{content}</body></html>"
#
# MarkdownRenderer class:
# - render(content) returns "# Document\n\n#{content}"
#
# PlainTextRenderer class:
# - render(content) returns content unchanged
#
# Document class:
# - initialize(content, renderer)
# - content reader
# - render method (delegates to the renderer)
# - change_renderer(new_renderer) to swap renderers at runtime

##
# Renders content as HTML
class HtmlRenderer
  def render(content)
    "<html><body>#{content}</body></html>"
  end
end

##
# Renders content as Markdown
class MarkdownRenderer
  def render(content)
    "# Document\n\n#{content}"
  end
end

##
# Renders content as Plain text
class PlainTextRenderer
  def render(content)
    content
  end
end

##
# Renders a document with a renderer via dependency-injection
class Document
  attr_reader :content

  def initialize(content, renderer)
    @content = content
    @renderer = renderer
  end

  def render
    @renderer.render(@content)
  end

  def change_renderer(new_renderer)
    @renderer = new_renderer
  end
end
