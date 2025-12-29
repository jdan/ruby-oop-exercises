# frozen_string_literal: true

# Single Responsibility Principle (SRP)
#
# Each class should have only ONE reason to change.
# This exercise separates concerns into focused classes:
# - SalesData: data storage and calculations
# - ReportFormatter: converting data to text output
# - FileWriter: file operations
# - SalesReportGenerator: orchestrating the components

module Chapter07
  # SalesData class:
  # - initialize(records) - array of hashes with :product, :quantity, :price
  # - records reader
  # - total_revenue - sum of quantity * price for all records
  # - top_seller - record with highest quantity (nil if empty)

  ##
  # Handles sales data storage and calculations
  SalesData = Struct.new(:records) do
    def total_revenue
      records.sum { |record| record[:quantity] * record[:price] }
    end

    def top_seller
      records.max_by { |record| record[:quantity] }
    end
  end

  # ReportFormatter class:
  # - format(sales_data) returns each record as "product: quantity @ price"
  #   Example: "Widget: 10 @ 5.0\nGadget: 5 @ 20.0"
  #   Returns empty string for empty records
  # - format_summary(sales_data) returns "Total Revenue: $X"
  #   Example: "Total Revenue: $150.0"

  ##
  # Formats sales data as plain text
  class ReportFormatter
    def format(sales_data)
      sales_data
        .records
        .map { |record| "#{record[:product]}: #{record[:quantity]} @ #{record[:price]}" }
        .join("\n")
    end

    def format_summary(sales_data)
      "Total Revenue: $#{sales_data.total_revenue}"
    end
  end

  # FileWriter class:
  # - write(filename, content) returns "Wrote X bytes to filename"
  #   Example: writer.write('report.txt', 'Hello') => "Wrote 5 bytes to report.txt"

  ##
  # Handles file output operations
  class FileWriter
    def write(filename, content)
      "Wrote #{content.length} bytes to #{filename}"
    end
  end

  # SalesReportGenerator class:
  # - initialize(sales_data, formatter, writer) - dependency injection
  # - sales_data, formatter, writer readers
  # - generate(filename) - combines format + "\n\n" + format_summary, writes result
  #   Returns the result from writer.write

  ##
  # Orchestrates report generation using injected dependencies
  class SalesReportGenerator
    attr_reader :sales_data, :formatter, :writer

    def initialize(sales_data, formatter, writer)
      @sales_data = sales_data
      @formatter = formatter
      @writer = writer
    end

    def generate(filename)
      writer.write filename, <<~CONTENTS.chomp
        #{formatter.format(sales_data)}

        #{formatter.format_summary(sales_data)}
      CONTENTS
    end
  end
end
