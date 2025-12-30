# frozen_string_literal: true

# Chapter 10: More Design Patterns
# Exercise 05: Command Pattern
#
# The Command pattern encapsulates a request as an object, allowing you to
# parameterize clients with different requests, queue or log requests, and
# support undoable operations.
#
# Scenario: A text editor with undo functionality
#
# Implement the following:
#
# 1. TextEditor class
#    - initialize - starts with empty content ('') and empty history ([])
#    - content - attr_accessor for the document content
#    - history - attr_reader for the command history (array of executed commands)
#    - execute(command) - calls command.execute and adds command to history
#    - undo - removes last command from history and calls its undo method
#             (does nothing if history is empty)
#
# 2. InsertCommand class
#    - initialize(editor, text) - stores the editor and text to insert
#    - editor - attr_reader
#    - text - attr_reader
#    - execute - appends text to editor.content
#    - undo - removes the inserted text from editor.content
#
# 3. DeleteCommand class
#    - initialize(editor, char_count) - stores editor and number of chars to delete
#    - editor - attr_reader
#    - char_count - attr_reader
#    - deleted_text - attr_reader (stores what was deleted, for undo)
#    - execute - removes char_count characters from end of editor.content
#                stores the deleted text in @deleted_text
#    - undo - appends deleted_text back to editor.content
#
# Hints:
#   - To remove last N chars: string[0...-n] or string.slice!(-(n)..-1)
#   - To append: string += other or string << other

module Chapter10
  ##
  # A simple text editor that supports command-based editing with undo
  class TextEditor
    # TODO: Implement initialize, content, content=, history, execute, undo
  end

  ##
  # Command to insert text at the end of the document
  class InsertCommand
    # TODO: Implement initialize, editor, text, execute, undo
  end

  ##
  # Command to delete characters from the end of the document
  class DeleteCommand
    # TODO: Implement initialize, editor, char_count, deleted_text, execute, undo
  end
end
