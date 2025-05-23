# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins(%r{(http://)((localhost:)|(127.0.0.1:))})

    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: %w[Content-Disposition Content-Type Content-Length]
  end

  allow do
    origins(%r{(https://)(.*izzicup.net)})

    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: %w[Content-Disposition Content-Type Content-Length]
  end

  allow do
    origins(%r{(https://)(.*dap-aero.com)})

    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: %w[Content-Disposition Content-Type Content-Length]
  end

  allow do
    origins(%r{(https://)(.*dap-aero.pages.dev)})

    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: %w[Content-Disposition Content-Type Content-Length]
  end
end
