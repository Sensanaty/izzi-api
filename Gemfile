# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.1'

gem 'pg', '~> 1.1'
gem 'rails', '~> 7.0.4'

gem 'bcrypt', '~> 3.1.7'
gem 'jwt'
gem 'puma', '~> 5.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'bootsnap', require: false
gem 'jb'
gem 'jsonapi-serializer'
gem 'pagy', '~> 5.10'
gem 'rack-cors'

group :development do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'faker', require: false
end

group :development do
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'spring'
end
