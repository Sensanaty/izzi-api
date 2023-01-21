# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login]

  def login
    @user = User.find_by_username(user_params[:username].downcase)

    if @user&.authenticate(user_params[:password])
      expiry = if user_params[:remember]
                 DateTime.now + 7.days
               else
                 30.minutes.from_now.to_i
               end

      token = encode({ user_id: @user.id }, expiry.to_i)

      render json: { user: @user.as_json.except('password_digest', 'updated_at', 'created_at'), token: }, status: :ok
    else
      render json: { error: 'Wrong username or email, please try again' }, status: :unauthorized
    end
  end

  def authenticate
    if @new_token
      render json: { token: @new_token }, status: :ok
    else
      head :no_content
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password, :remember)
  end
end
