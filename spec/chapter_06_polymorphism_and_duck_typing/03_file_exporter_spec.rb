# frozen_string_literal: true

require 'chapter_06_polymorphism_and_duck_typing/03_file_exporter'

RSpec.describe Chapter06::CsvExporter do
  describe '#export' do
    it 'exports data as CSV format' do
      exporter = described_class.new
      data = [
        { name: 'Alice', age: 30 },
        { name: 'Bob', age: 25 }
      ]

      result = exporter.export(data)

      expect(result).to eq("name,age\nAlice,30\nBob,25")
    end

    it 'handles single row' do
      exporter = described_class.new
      data = [{ name: 'Charlie', age: 35 }]

      result = exporter.export(data)

      expect(result).to eq("name,age\nCharlie,35")
    end

    it 'handles empty data' do
      exporter = described_class.new

      result = exporter.export([])

      expect(result).to eq('')
    end
  end

  describe '#file_extension' do
    it 'returns csv' do
      expect(described_class.new.file_extension).to eq('csv')
    end
  end
end

RSpec.describe Chapter06::JsonExporter do
  describe '#export' do
    it 'exports data as JSON format' do
      exporter = described_class.new
      data = [
        { name: 'Alice', age: 30 },
        { name: 'Bob', age: 25 }
      ]

      result = exporter.export(data)

      expect(result).to eq('[{"name":"Alice","age":30},{"name":"Bob","age":25}]')
    end

    it 'handles empty data' do
      exporter = described_class.new

      result = exporter.export([])

      expect(result).to eq('[]')
    end
  end

  describe '#file_extension' do
    it 'returns json' do
      expect(described_class.new.file_extension).to eq('json')
    end
  end
end

RSpec.describe Chapter06::XmlExporter do
  describe '#export' do
    it 'exports data as XML format' do
      exporter = described_class.new
      data = [
        { name: 'Alice', age: 30 },
        { name: 'Bob', age: 25 }
      ]

      result = exporter.export(data)

      expected = "<records>\n" \
                 "<record><name>Alice</name><age>30</age></record>\n" \
                 "<record><name>Bob</name><age>25</age></record>\n" \
                 '</records>'
      expect(result).to eq(expected)
    end

    it 'handles empty data' do
      exporter = described_class.new

      result = exporter.export([])

      expect(result).to eq("<records>\n</records>")
    end
  end

  describe '#file_extension' do
    it 'returns xml' do
      expect(described_class.new.file_extension).to eq('xml')
    end
  end
end

RSpec.describe Chapter06::ReportGenerator do
  describe '#initialize' do
    it 'creates a generator with an exporter' do
      exporter = Chapter06::CsvExporter.new
      generator = described_class.new(exporter)

      expect(generator.exporter).to eq(exporter)
    end
  end

  describe '#generate' do
    it 'generates report using CSV exporter' do
      exporter = Chapter06::CsvExporter.new
      generator = described_class.new(exporter)
      data = [{ name: 'Test', value: 100 }]

      result = generator.generate(data)

      expect(result).to eq("name,value\nTest,100")
    end

    it 'generates report using JSON exporter' do
      exporter = Chapter06::JsonExporter.new
      generator = described_class.new(exporter)
      data = [{ name: 'Test', value: 100 }]

      result = generator.generate(data)

      expect(result).to eq('[{"name":"Test","value":100}]')
    end
  end

  describe '#suggested_filename' do
    it 'returns filename with correct extension' do
      csv_exporter = Chapter06::CsvExporter.new
      generator = described_class.new(csv_exporter)

      expect(generator.suggested_filename('report')).to eq('report.csv')
    end

    it 'uses exporter file extension' do
      json_exporter = Chapter06::JsonExporter.new
      generator = described_class.new(json_exporter)

      expect(generator.suggested_filename('data')).to eq('data.json')
    end
  end

  describe '#change_exporter' do
    it 'allows switching exporters' do
      csv_exporter = Chapter06::CsvExporter.new
      xml_exporter = Chapter06::XmlExporter.new
      generator = described_class.new(csv_exporter)

      generator.change_exporter(xml_exporter)

      expect(generator.suggested_filename('report')).to eq('report.xml')
    end
  end
end
