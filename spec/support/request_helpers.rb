# frozen_string_literal: true

module RequestHelpers
  SECRET_KEY = Rails.application.secret_key_base

  def get_token(user, expiry = 5.minutes.from_now)
    JWT.encode({ user_id: user.id, expiry: expiry.to_i }, SECRET_KEY)
  end

  def decode_token(token)
    JWT.decode(token, SECRET_KEY)
  end

  def parse_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
