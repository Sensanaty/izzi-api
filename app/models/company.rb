# frozen_string_literal: true

class Company < ApplicationRecord
  validates_presence_of :name

  has_many :clients, dependent: :destroy
  has_many :parts, dependent: :destroy, counter_cache: true
end
