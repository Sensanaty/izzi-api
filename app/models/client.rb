# frozen_string_literal: true

class Client < ApplicationRecord
  belongs_to :company
  has_many :parts, through: :company
end
