# frozen_string_literal: true

class User < ApplicationRecord
  require 'securerandom'

  has_secure_password

  validates :email, presence: true
  validates :password, presence: true
  validates :username, presence: true, uniqueness: true
  validate :password_length

  def admin?
    admin == true
  end

  def password_length
    return unless password

    if admin? && password.length < 12
      errors.add(:password, 'Password was too short, enter at least 12 characters')
    elsif password.length < 9
      errors.add(:password, 'Password was too short, enter at least 9 characters')
    end
  end
end
