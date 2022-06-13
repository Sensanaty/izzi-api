# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JsonWebToken

  rescue_from JWT::DecodeError do
    render json: { error: 'Error decoding auth token, try logging in again' }, status: :unprocessable_entity
  end

  before_action :authenticate_request

  private

  def auth_token
    request.headers['Authorization'].split[1]
  end

  def generate_new_token(expiry, user_id, current_time)
    @new_token = encode({ user_id: }) if current_time + 10.minutes.to_i > expiry
  end

  def authenticate_request
    render json: { message: 'No Authorization Header found' }, status: :unauthorized if auth_token == 'undefined'

    decoded_token = decode(auth_token)
    current_time = DateTime.now.to_i

    if current_time < decoded_token[:expiry]
      generate_new_token(decoded_token[:expiry], decoded_token[:user_id], current_time)
      @current_user = User.find(decoded_token[:user_id])
    else
      render json: { error: 'Auth token expired, please login again' }, status: :unauthorized
    end
  end
end
