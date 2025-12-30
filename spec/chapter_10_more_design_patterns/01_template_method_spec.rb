# frozen_string_literal: true

require 'chapter_10_more_design_patterns/01_template_method'

RSpec.describe Chapter10::DataExporter do
  # DataExporter is an abstract base class that defines the template method
  # Subclasses should implement: fetch_data, format_data, write_output

  describe '#export' do
    it 'calls the steps in the correct order' do
      exporter = Chapter10::CsvExporter.new
      call_order = []

      allow(exporter).to receive(:fetch_data).and_wrap_original do |method|
        call_order << :fetch_data
        method.call
      end

      allow(exporter).to receive(:format_data).and_wrap_original do |method, *args|
        call_order << :format_data
        method.call(*args)
      end

      allow(exporter).to receive(:write_output).and_wrap_original do |method, *args|
        call_order << :write_output
        method.call(*args)
      end

      exporter.export

      expect(call_order).to eq(%i[fetch_data format_data write_output])
    end
  end
end

RSpec.describe Chapter10::CsvExporter do
  let(:exporter) { described_class.new }

  describe '#fetch_data' do
    it 'returns an array of hashes' do
      data = exporter.fetch_data
      expect(data).to be_an(Array)
      expect(data.first).to be_a(Hash)
    end

    it 'returns sample user data' do
      data = exporter.fetch_data
      expect(data.first).to include(:name, :email)
    end
  end

  describe '#format_data' do
    it 'formats data as CSV string' do
      data = [{ name: 'Alice', email: 'alice@example.com' }]
      formatted = exporter.format_data(data)

      expect(formatted).to include('name,email')
      expect(formatted).to include('Alice,alice@example.com')
    end

    it 'handles multiple rows' do
      data = [
        { name: 'Alice', email: 'alice@example.com' },
        { name: 'Bob', email: 'bob@example.com' }
      ]
      formatted = exporter.format_data(data)

      lines = formatted.strip.split("\n")
      expect(lines.length).to eq(3) # header + 2 rows
    end
  end

  describe '#write_output' do
    it 'returns the formatted string with csv extension indicator' do
      result = exporter.write_output('name,email')
      expect(result).to include('name,email')
      expect(result).to include('.csv')
    end
  end

  describe '#export' do
    it 'performs the full export pipeline' do
      result = exporter.export
      expect(result).to include('.csv')
      expect(result).to include('name,email')
    end
  end
end

RSpec.describe Chapter10::JsonExporter do
  let(:exporter) { described_class.new }

  describe '#fetch_data' do
    it 'returns an array of hashes' do
      data = exporter.fetch_data
      expect(data).to be_an(Array)
      expect(data.first).to be_a(Hash)
    end
  end

  describe '#format_data' do
    it 'formats data as JSON string' do
      data = [{ name: 'Alice', email: 'alice@example.com' }]
      formatted = exporter.format_data(data)

      parsed = JSON.parse(formatted)
      expect(parsed.first['name']).to eq('Alice')
    end

    it 'produces valid JSON for multiple items' do
      data = [
        { name: 'Alice', email: 'alice@example.com' },
        { name: 'Bob', email: 'bob@example.com' }
      ]
      formatted = exporter.format_data(data)

      parsed = JSON.parse(formatted)
      expect(parsed.length).to eq(2)
    end
  end

  describe '#write_output' do
    it 'returns the formatted string with json extension indicator' do
      result = exporter.write_output('{"name":"Alice"}')
      expect(result).to include('{"name":"Alice"}')
      expect(result).to include('.json')
    end
  end

  describe '#export' do
    it 'performs the full export pipeline' do
      result = exporter.export
      expect(result).to include('.json')

      # The result should contain valid JSON data
      json_match = result.match(/Output to .+\.json:\n(.+)/m)
      expect(json_match).not_to be_nil
    end
  end
end
