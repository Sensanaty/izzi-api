# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user, :admin) }
  let!(:regular) { create(:user) }

  describe 'validations' do
    context 'should validate the presence of' do
      it 'username' do
        should validate_presence_of(:username)
      end

      context 'password' do
        it 'should have secure password' do
          should have_secure_password
        end

        it 'is present' do
          should validate_presence_of(:password)
        end

        it 'is long enough for admin' do
          user.password = '12345679'
          expect(user).not_to be_valid

          user.password = '123456789012'
          expect(user).to be_valid
        end

        it 'is long enough for non admin' do
          regular.password = '12345678'
          expect(regular).not_to be_valid

          regular.password = '123456789'
          expect(regular).to be_valid
        end
      end

      it 'email' do
        should validate_presence_of(:email)
      end
    end
  end

  it 'should be able to be an admin' do
    expect(regular.admin?).to be_falsey

    regular.admin = true
    expect(regular.admin?).to be_truthy
  end
end
