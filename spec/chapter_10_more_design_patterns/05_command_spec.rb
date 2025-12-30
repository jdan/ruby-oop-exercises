# frozen_string_literal: true

require 'chapter_10_more_design_patterns/05_command'

RSpec.describe Chapter10::TextEditor do
  let(:editor) { described_class.new }

  describe '#initialize' do
    it 'starts with empty content' do
      expect(editor.content).to eq('')
    end

    it 'starts with empty history' do
      expect(editor.history).to be_empty
    end
  end

  describe '#content' do
    it 'returns the current document content' do
      expect(editor.content).to eq('')
    end
  end

  describe '#content=' do
    it 'sets the content directly' do
      editor.content = 'Hello'
      expect(editor.content).to eq('Hello')
    end
  end

  describe '#execute' do
    it 'executes a command and adds it to history' do
      command = Chapter10::InsertCommand.new(editor, 'Hello')
      editor.execute(command)

      expect(editor.content).to eq('Hello')
      expect(editor.history.length).to eq(1)
    end

    it 'can execute multiple commands' do
      editor.execute(Chapter10::InsertCommand.new(editor, 'Hello'))
      editor.execute(Chapter10::InsertCommand.new(editor, ' World'))

      expect(editor.content).to eq('Hello World')
      expect(editor.history.length).to eq(2)
    end
  end

  describe '#undo' do
    it 'undoes the last command' do
      editor.execute(Chapter10::InsertCommand.new(editor, 'Hello'))
      editor.undo

      expect(editor.content).to eq('')
    end

    it 'undoes commands in reverse order' do
      editor.execute(Chapter10::InsertCommand.new(editor, 'Hello'))
      editor.execute(Chapter10::InsertCommand.new(editor, ' World'))

      editor.undo
      expect(editor.content).to eq('Hello')

      editor.undo
      expect(editor.content).to eq('')
    end

    it 'removes the command from history' do
      editor.execute(Chapter10::InsertCommand.new(editor, 'Hello'))
      editor.undo

      expect(editor.history).to be_empty
    end

    it 'does nothing when history is empty' do
      expect { editor.undo }.not_to raise_error
      expect(editor.content).to eq('')
    end
  end
end

RSpec.describe Chapter10::InsertCommand do
  let(:editor) { Chapter10::TextEditor.new }

  describe '#initialize' do
    it 'stores the editor and text to insert' do
      command = described_class.new(editor, 'Hello')
      expect(command.editor).to eq(editor)
      expect(command.text).to eq('Hello')
    end
  end

  describe '#execute' do
    it 'appends text to the editor content' do
      command = described_class.new(editor, 'Hello')
      command.execute

      expect(editor.content).to eq('Hello')
    end

    it 'appends to existing content' do
      editor.content = 'Hello'
      command = described_class.new(editor, ' World')
      command.execute

      expect(editor.content).to eq('Hello World')
    end
  end

  describe '#undo' do
    it 'removes the inserted text' do
      command = described_class.new(editor, 'Hello')
      command.execute
      command.undo

      expect(editor.content).to eq('')
    end

    it 'only removes the text that was inserted' do
      editor.content = 'Hello'
      command = described_class.new(editor, ' World')
      command.execute
      command.undo

      expect(editor.content).to eq('Hello')
    end
  end
end

RSpec.describe Chapter10::DeleteCommand do
  let(:editor) { Chapter10::TextEditor.new }

  describe '#initialize' do
    it 'stores the editor and number of characters to delete' do
      command = described_class.new(editor, 5)
      expect(command.editor).to eq(editor)
      expect(command.char_count).to eq(5)
    end
  end

  describe '#execute' do
    it 'removes characters from the end of content' do
      editor.content = 'Hello World'
      command = described_class.new(editor, 6)
      command.execute

      expect(editor.content).to eq('Hello')
    end

    it 'stores the deleted text for undo' do
      editor.content = 'Hello World'
      command = described_class.new(editor, 6)
      command.execute

      expect(command.deleted_text).to eq(' World')
    end

    it 'handles deleting more characters than exist' do
      editor.content = 'Hi'
      command = described_class.new(editor, 10)
      command.execute

      expect(editor.content).to eq('')
      expect(command.deleted_text).to eq('Hi')
    end
  end

  describe '#undo' do
    it 'restores the deleted text' do
      editor.content = 'Hello World'
      command = described_class.new(editor, 6)
      command.execute
      command.undo

      expect(editor.content).to eq('Hello World')
    end
  end
end

RSpec.describe 'Complex editing scenario' do
  let(:editor) { Chapter10::TextEditor.new }

  it 'supports a realistic editing session with undo' do
    # Type "Hello World"
    editor.execute(Chapter10::InsertCommand.new(editor, 'Hello World'))
    expect(editor.content).to eq('Hello World')

    # Delete " World"
    editor.execute(Chapter10::DeleteCommand.new(editor, 6))
    expect(editor.content).to eq('Hello')

    # Add " Ruby"
    editor.execute(Chapter10::InsertCommand.new(editor, ' Ruby'))
    expect(editor.content).to eq('Hello Ruby')

    # Undo: remove " Ruby"
    editor.undo
    expect(editor.content).to eq('Hello')

    # Undo: restore " World"
    editor.undo
    expect(editor.content).to eq('Hello World')

    # Undo: remove "Hello World"
    editor.undo
    expect(editor.content).to eq('')
  end
end
