# frozen_string_literal: true

Mime::Type.register 'text/csv', :csv unless Mime::Type.lookup_by_extension(:csv)
