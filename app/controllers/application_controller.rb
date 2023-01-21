# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pagy::Backend
  include Errors
  include JsonWebToken

  rescue_from JWT::DecodeError do
    render json: { error: 'Error decoding auth token, try logging in again' }, status: :unprocessable_entity
  end

  rescue_from NoHeaderError do
    render json: { error: 'No auth header found' }, status: :unauthorized
  end

  before_action :authenticate_request

  private

  def auth_token
    request.headers['Authorization']

  rescue NoMethodError
    raise NoHeaderError
  end

  def generate_new_token(expiry, user_id, current_time)
    encode({ user_id: }) if current_time + 10.minutes.to_i > expiry
  end

  def authenticate_request
    decoded_token = decode(auth_token)
    current_time = DateTime.now.to_i

    if current_time < decoded_token[:expiry]
      @new_token = generate_new_token(decoded_token[:expiry], decoded_token[:user_id], current_time)
      @current_user = User.find(decoded_token[:user_id])
    else
      render json: { error: 'Authorization token expired, please login again' }, status: :unauthorized
    end
  end
end
