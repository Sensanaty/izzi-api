# frozen_string_literal: true

class Part < ApplicationRecord
  belongs_to :company, dependent: :destroy, counter_cache: true

  has_paper_trail limit: 10

  enum quote_type: {
    outright_sale: 'OUTRIGHT SALE',
    flat_rate_exchange: 'FLAT RATE EXCHANGE',
    exchange_plus_cost: 'EXCHANGE + COST'
  }
  validates :quote_type, presence: true
end
