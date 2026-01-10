# frozen_string_literal: true

# Chapter 10: More Design Patterns
# Exercise 01: Template Method Pattern
#
# The Template Method pattern defines the skeleton of an algorithm in a base
# class, letting subclasses override specific steps without changing the
# algorithm's structure.
#
# Implement the following:
#
# 1. DataExporter (base class)
#    - export - the template method that calls: fetch_data, format_data, write_output
#      (This method should be implemented in the base class and NOT overridden)
#    - fetch_data - abstract method (raise NotImplementedError)
#    - format_data(data) - abstract method (raise NotImplementedError)
#    - write_output(formatted) - abstract method (raise NotImplementedError)
#
# 2. CsvExporter (subclass of DataExporter)
#    - fetch_data - returns sample data as array of hashes
#      e.g., [{ name: 'Alice', email: 'alice@example.com' }, ...]
#    - format_data(data) - converts data to CSV format string
#      (header row + data rows)
#    - write_output(formatted) - returns "Output to export.csv:\n#{formatted}"
#
# 3. JsonExporter (subclass of DataExporter)
#    - fetch_data - returns sample data as array of hashes
#    - format_data(data) - converts data to JSON string (use JSON.generate)
#    - write_output(formatted) - returns "Output to export.json:\n#{formatted}"
#
# Hint: require 'json' for JSON.generate

require 'json'

module Chapter10
  ##
  # Abstract base class that defines the template method for data export
  class DataExporter
    def export
      data = fetch_data
      formatted = format_data(data)
      write_output(formatted)
    end

    def fetch_data
      [
        {
          name: 'Alice', email: 'alice@example.com'
        }
      ]
    end

    def format_data(data) = raise NotImplementedError
    def write_output(formatted) = raise NotImplementedError
  end

  ##
  # Exports data in CSV format
  class CsvExporter < DataExporter
    def format_data(data)
      <<~CSV
        #{data.first.keys.join(',')}
        #{data.map { |row| row.values.join(',') }.join("\n")}
      CSV
    end

    def write_output(formatted)
      "Output to export.csv:\n#{formatted}"
    end
  end

  ##
  # Exports data in JSON format
  class JsonExporter < DataExporter
    def format_data(data)
      JSON.generate(data)
    end

    def write_output(formatted)
      "Output to export.json:\n#{formatted}"
    end
  end
end
