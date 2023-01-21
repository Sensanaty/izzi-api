# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login]

  def login
    @user = User.find_by_username(user_params[:username].downcase)

    if @user&.authenticate(user_params[:password])
      expiry = if user_params[:expiry]
                 user_params[:expiry] + DateTime.now.to_i
               elsif user_params[:remember]
                 DateTime.now + 7.days
               else
                 60.minutes.from_now.to_i
               end

      token = encode({ user_id: @user.id }, expiry.to_i)

      render json: { token: }, status: :ok
    else
      render json: { error: 'Wrong username or email, please try again' }, status: :unauthorized
    end
  end

  def authenticate; end

  private

  def user_params
    params.require(:data).permit(:username, :email, :password, :remember, :expiry)
  end
end
