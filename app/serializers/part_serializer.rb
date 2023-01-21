# frozen_string_literal: true

class PartSerializer
  include JSONAPI::Serializer

  attributes :id,
             :part_number,
             :description,
             :available,
             :reserved,
             :sold,
             :condition,
             :min_cost,
             :min_price,
             :min_order,
             :med_cost,
             :med_price,
             :med_order,
             :max_cost,
             :max_price,
             :max_order,
             :lead_time,
             :quote_type,
             :tag,
             :added

  belongs_to :company
end
