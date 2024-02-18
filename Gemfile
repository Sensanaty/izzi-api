# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

gem 'pg', '~> 1.5'
gem 'rails', '~> 7.1.2'

gem 'bcrypt', '~> 3.1'
gem 'jwt'
gem 'puma', '~> 6.4'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'bootsnap', require: false
gem 'jb'
gem 'jsonapi-serializer'
gem 'pagy', '~> 6.2'
gem 'rack-cors'
gem 'faker'

group :development do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'spring'
end

gem "dockerfile-rails", ">= 1.6", :group => :development
