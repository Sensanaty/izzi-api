class Company < ApplicationRecord
  has_many :clients, dependent: :destroy
  has_many :parts, dependent: :destroy
end
