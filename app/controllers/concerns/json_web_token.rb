# frozen_string_literal: true

require 'jwt'

module JsonWebToken
  extend ActiveSupport::Concern

  SECRET_KEY = Rails.application.secret_key_base

  def encode(payload, expiry = 1.hours.from_now)
    payload[:expiry] = expiry.to_i

    JWT.encode(payload, SECRET_KEY)
  end

  def decode(token)
    unless token
      render json: { message: 'No authorization token found in request header' }, status: :unauthorized and return
    end

    decoded = JWT.decode(token, SECRET_KEY)[0]

    HashWithIndifferentAccess.new(decoded)
  end
end
