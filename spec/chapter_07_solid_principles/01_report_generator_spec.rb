# frozen_string_literal: true

require 'chapter_07_solid_principles/01_report_generator'

RSpec.describe Chapter07::SalesData do
  let(:records) do
    [
      { product: 'Widget', quantity: 10, price: 5.00 },
      { product: 'Gadget', quantity: 5, price: 20.00 },
      { product: 'Gizmo', quantity: 8, price: 12.50 }
    ]
  end

  describe '#initialize' do
    it 'creates sales data with records' do
      data = described_class.new(records)

      expect(data.records).to eq(records)
    end

    it 'handles empty records' do
      data = described_class.new([])

      expect(data.records).to eq([])
    end
  end

  describe '#total_revenue' do
    it 'calculates the sum of quantity * price for all records' do
      data = described_class.new(records)

      # 10*5 + 5*20 + 8*12.50 = 50 + 100 + 100 = 250
      expect(data.total_revenue).to eq(250.0)
    end

    it 'returns 0 for empty records' do
      data = described_class.new([])

      expect(data.total_revenue).to eq(0)
    end
  end

  describe '#top_seller' do
    it 'returns the record with the highest quantity' do
      data = described_class.new(records)

      expect(data.top_seller).to eq({ product: 'Widget', quantity: 10, price: 5.00 })
    end

    it 'returns nil for empty records' do
      data = described_class.new([])

      expect(data.top_seller).to be_nil
    end
  end
end

RSpec.describe Chapter07::ReportFormatter do
  let(:records) do
    [
      { product: 'Widget', quantity: 10, price: 5.00 },
      { product: 'Gadget', quantity: 5, price: 20.00 }
    ]
  end
  let(:sales_data) { Chapter07::SalesData.new(records) }

  describe '#format' do
    it 'returns each record as "product: quantity @ price"' do
      formatter = described_class.new

      result = formatter.format(sales_data)

      expect(result).to eq("Widget: 10 @ 5.0\nGadget: 5 @ 20.0")
    end

    it 'returns empty string for empty records' do
      formatter = described_class.new
      empty_data = Chapter07::SalesData.new([])

      result = formatter.format(empty_data)

      expect(result).to eq('')
    end
  end

  describe '#format_summary' do
    it 'returns "Total Revenue: $X"' do
      formatter = described_class.new

      result = formatter.format_summary(sales_data)

      expect(result).to eq('Total Revenue: $150.0')
    end
  end
end

RSpec.describe Chapter07::FileWriter do
  describe '#write' do
    it 'returns confirmation with byte count' do
      writer = described_class.new

      result = writer.write('report.txt', 'Hello World')

      expect(result).to eq('Wrote 11 bytes to report.txt')
    end

    it 'handles empty content' do
      writer = described_class.new

      result = writer.write('empty.txt', '')

      expect(result).to eq('Wrote 0 bytes to empty.txt')
    end
  end
end

RSpec.describe Chapter07::SalesReportGenerator do
  let(:records) do
    [
      { product: 'Widget', quantity: 10, price: 5.00 },
      { product: 'Gadget', quantity: 5, price: 20.00 }
    ]
  end
  let(:sales_data) { Chapter07::SalesData.new(records) }
  let(:formatter) { Chapter07::ReportFormatter.new }
  let(:writer) { Chapter07::FileWriter.new }

  describe '#initialize' do
    it 'receives dependencies via constructor' do
      generator = described_class.new(sales_data, formatter, writer)

      expect(generator.sales_data).to eq(sales_data)
      expect(generator.formatter).to eq(formatter)
      expect(generator.writer).to eq(writer)
    end
  end

  describe '#generate' do
    it 'formats data and summary, then writes to file' do
      generator = described_class.new(sales_data, formatter, writer)

      result = generator.generate('sales.txt')

      # Content: "Widget: 10 @ 5.0\nGadget: 5 @ 20.0\n\nTotal Revenue: $150.0" = 56 bytes
      expect(result).to eq('Wrote 56 bytes to sales.txt')
    end
  end
end
