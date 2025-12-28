# frozen_string_literal: true

# Implement the exporter classes and ReportGenerator here
#
# This exercise demonstrates polymorphism with different export formats.
# All exporters share the same interface: export(data) and file_extension.
#
# CsvExporter class:
# - export(data) converts array of hashes to CSV string
#   - First line: keys as comma-separated headers
#   - Following lines: values as comma-separated rows
#   - Returns empty string for empty array
# - file_extension returns "csv"
#
# JsonExporter class:
# - export(data) converts array of hashes to JSON string
#   - Hint: require 'json' and use .to_json
# - file_extension returns "json"
#
# XmlExporter class:
# - export(data) converts array of hashes to XML string
#   - Wrap all records in <records>...</records>
#   - Each hash becomes <record><key>value</key>...</record>
#   - Empty data returns "<records>\n</records>"
# - file_extension returns "xml"
#
# ReportGenerator class:
# - initialize(exporter)
# - exporter reader
# - generate(data) delegates to exporter.export(data)
# - suggested_filename(base_name) returns "#{base_name}.#{exporter.file_extension}"
# - change_exporter(new_exporter) swaps the exporter

require 'json'
