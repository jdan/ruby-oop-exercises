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
    # TODO: Implement the template method and abstract methods
  end

  ##
  # Exports data in CSV format
  class CsvExporter < DataExporter
    # TODO: Implement CSV-specific export steps
  end

  ##
  # Exports data in JSON format
  class JsonExporter < DataExporter
    # TODO: Implement JSON-specific export steps
  end
end
