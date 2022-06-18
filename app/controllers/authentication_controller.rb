# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login]

  def login
    @user = User.find_by_username(user_params[:username])

    if @user&.authenticate(user_params[:password])
      expiry = user_params[:remember] ? current_time + 7.days.from_now : 60.minutes.from_now

      token = encode({ user_id: @user.id }, expiry)

      render json: { token: }, status: :ok
    else
      render json: { error: 'Wrong username or email, please try again' }, status: :unauthorized
    end
  end

  def authenticate
    if @new_token
      render json: { token: @new_token }, status: :ok
    else
      head 204
    end
  end

  private

  def user_params
    params.require(:data).permit(:username, :email, :password, :remember)
  end
end
