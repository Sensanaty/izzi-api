# frozen_string_literal: true

module CsvExportable
  extend ActiveSupport::Concern

  def export_csv(records, options = {})
    require 'csv'

    model_class = options[:model_class] || records.model
    attributes = options[:attributes] || model_class.column_names
    filename = options[:filename] ||
               "#{model_class.name.underscore.pluralize}_#{Time.current.strftime('%Y_%m_%d-%H_%M_%S')}.csv"

    csv_data = generate_csv(records, attributes)

    send_data(csv_data, filename:, disposition: 'attachment', type: 'text/csv')
  end

  private

  def generate_csv(records, attributes)
    CSV.generate(headers: true, force_quotes: true) do |csv|
      csv << attributes.map { |attr| attr.to_s.humanize }

      records.each do |record|
        csv << attributes.map { |attr| record.send(attr) }
      end
    end
  end
end
