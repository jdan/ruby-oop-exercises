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
