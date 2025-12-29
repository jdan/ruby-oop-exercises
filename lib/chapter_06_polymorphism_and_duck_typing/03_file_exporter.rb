# frozen_string_literal: true

require 'json'

# Implement the exporter classes and ReportGenerator here
#
# This exercise demonstrates polymorphism with different export formats.
# All exporters share the same interface: export(data) and file_extension.

##
# A CSV exporter
class CsvExporter
  def export(data)
    return '' if data.empty?

    [keys(data), *values(data)].join("\n")
  end

  def keys(data)
    data.first.keys.join(',')
  end

  def values(data)
    data.map { |hash| hash.values.join(',') }.join("\n")
  end

  def file_extension = 'csv'
end

##
# A JSON exporter
class JsonExporter
  def export(data)
    data.to_json
  end

  def file_extension = 'json'
end

##
# An XML exporter
class XmlExporter
  def export(data)
    return "<records>\n</records>" if data.empty?

    <<~XML.chomp
      <records>
      #{records_to_xml(data)}
      </records>
    XML
  end

  def records_to_xml(data)
    data.map { |record| record_to_xml(record) }.join "\n"
  end

  def record_to_xml(record)
    key_value = record.map { |key, value| "<#{key}>#{value}</#{key}>" }.join
    "<record>#{key_value}</record>"
  end

  def file_extension = 'xml'
end

##
# A generator that is given an exporter to delegate to
class ReportGenerator
  attr_reader :exporter

  def initialize(exporter)
    @exporter = exporter
  end

  def generate(data)
    @exporter.export(data)
  end

  def suggested_filename(base_name)
    "#{base_name}.#{exporter.file_extension}"
  end

  def change_exporter(new_exporter)
    @exporter = new_exporter
  end
end
