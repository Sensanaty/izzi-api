# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy update]
  around_action :check_admin, except: [:show, :update]

  def show
    if @current_user == @user
      render json: @user, except: [:password_digest], status: :ok
    else
      unauthorize
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, except: %i[password_digest created_at updated_at], status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @current_user.admin? || @current_user == @user
      if @user.update(user_params)
        render json: @user, except: [:password_digest], status: :accepted
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      unauthorize
    end
  end

  def destroy
    if @user.admin?
      unauthorize
    else
      @user.destroy
      head 200
    end
  end

  private

  def user_params
    params.permit(:id, :username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_admin
    if @current_user.admin?
      yield
    else
      unauthorize
    end
  end

  def unauthorize
    render json: { error: 'You do not have permission to perform that action' }, status: :unauthorized
  end
end
