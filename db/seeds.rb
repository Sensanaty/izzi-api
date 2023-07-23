# frozen_string_literal: true

require 'faker'

User.destroy_all
Company.destroy_all
Client.destroy_all
Part.destroy_all

User.create(
  username: 'sensanaty',
  email: 'sensanati@gmail.com',
  password: 'Password12345',
  admin: true
)

5.times do
  Company.create(
    name: Faker::Company.unique.name,
    address: Faker::Address.street_name + Faker::Address.street_address
  )
end

Company.all.each do |company|
  4.times do
    Client.create(
      name: Faker::Name.name,
      number: Faker::PhoneNumber.cell_phone_in_e164,
      email: Faker::Internet.unique.email,
      company:
    )
  end

  10.times do
    part = Part.new(
      part_number: rand(0..4).to_s + Faker::IndustrySegments.sector.gsub(' ', '') + rand(0..10).to_s,
      description: Faker::Lorem.paragraph,
      available: rand(0..50),
      reserved: rand(0..50),
      sold: rand(0..50),
      condition: 'NE',
      min_cost: rand(0.00..5000.99),
      min_price: rand(0.00..5000.99),
      min_order: rand(0..50),
      med_cost: rand(0.00..5000.99),
      med_price: rand(0.00..5000.99),
      med_order: rand(0..50),
      max_cost: rand(0.00..5000.99),
      max_price: rand(0.00..5000.99),
      max_order: rand(0..50),
      tag: Faker::Lorem.paragraph,
      company:
    )

    puts part.errors.full_messages unless part.save
  end
end

puts '🔥 🔥 🔥 Seeding Completed 🔥 🔥 🔥'
