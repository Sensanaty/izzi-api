# frozen_string_literal: true

class Part < ApplicationRecord
  has_paper_trail limit: 10

  belongs_to :company, dependent: :destroy

  enum quote_type: {
    outright_sale: 'OUTRIGHT SALE',
    flat_rate_exchange: 'FLAT RATE EXCHANGE',
    exchange_plus_cost: 'EXCHANGE + COST'
  }
  validates :quote_type, presence: true
end
