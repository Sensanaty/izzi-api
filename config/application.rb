# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'rack'
require 'rack/brotli'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IzziApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.hosts << 'api.izzicup.net'
    config.hosts << 'api.dap-aero.com'
    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.action_controller.always_permitted_parameters = %w( controller action format )

    config.middleware.use Rack::Deflater
    config.middleware.use Rack::Brotli, quality: 11
  end
end
