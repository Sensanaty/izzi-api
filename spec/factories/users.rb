# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email.downcase }
    username { Faker::Internet.username.downcase }
    password { SecureRandom.alphanumeric(15) }

    trait :admin do
      admin { true }
    end
  end
end
