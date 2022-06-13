# frozen_string_literal: true

require 'rails_helper'
require 'faker'
require_relative '../support/request_helpers'

RSpec.configure { |c| c.include RequestHelpers }

RSpec.describe UsersController, type: :controller do
  let!(:authorized) { create(:user, :admin) }
  let!(:unauthorized) { create(:user) }

  describe 'GET /index' do
    it 'returns a 404' do
      expect { get :index }.to raise_error(ActionController::UrlGenerationError)
    end
  end

  describe 'GET /show' do
    before { request.headers['Authorization'] = "Bearer #{get_token(authorized)}" }

    it 'should not let unauthorized users see other user data' do
      request.headers['Authorization'] = "Bearer #{get_token(unauthorized)}"
      get :show, params: { id: authorized.id }

      expect(response.status).to eq(401)
    end

    it 'should let authorized users see their own data' do
      get :show, params: { id: authorized.id }

      expect(response.status).to eq(200)
    end

    it 'should deliver the correct data' do
      get :show, params: { id: authorized.id }

      parsed_response = parse_response(response)

      expect(parsed_response).to include(id: authorized.id)
      expect(parsed_response).to include(username: authorized.username)
      expect(parsed_response).to include(email: authorized.email)
      expect(parsed_response).to include(admin: authorized.admin)
      expect(parsed_response).to_not include(password_digest: authorized.password_digest)
    end
  end

  describe 'POST /create' do
    let(:new_user) do
      { username: Faker::Internet.username, email: Faker::Internet.email, password: SecureRandom.alphanumeric(15) }
    end

    before do
      request.headers['Authorization'] = "Bearer #{get_token(authorized)}"
    end

    it 'should create and return proper user' do
      post :create, params: new_user

      expect(response.status).to eq(201)

      parsed_response = parse_response(response)
      expect(parsed_response).to include(:id)
      expect(parsed_response).to include(username: new_user[:username])
      expect(parsed_response).to include(email: new_user[:email])
      expect(parsed_response).to include(:admin)
      expect(parsed_response).to_not include(:password_digest)
      expect(parsed_response).to_not include(:created_at)
      expect(parsed_response).to_not include(:updated_at)
    end

    it 'should error out on incorrect new user' do
      post :create, params: {}

      expect(response.status).to eq(422)
    end

    it 'should not let non-admin create new users' do
      request.headers['Authorization'] = "Bearer #{get_token(unauthorized)}"
      post :create, params: new_user

      expect(response.status).to eq(401)
    end
  end

  describe 'POST /update' do
    before { request.headers['Authorization'] = "Bearer #{get_token(authorized)}" }

    context 'as admin' do
      it 'should be able to update self' do
        put :update, params: {
          id: authorized.id,
          username: Faker::Internet.username,
          password: authorized.password,
          email: authorized.email
        }

        expect(response.status).to eq(202)
        parsed_response = parse_response(response)
        expect(authorized.id).to match(parsed_response[:id])
        expect(authorized.username).not_to match(parsed_response[:username])
      end

      it 'should be able to update other users' do
        put :update, params: {
          id: unauthorized.id,
          username: Faker::Internet.username,
          password: unauthorized.password,
          email: unauthorized.email
        }

        expect(response.status).to eq(202)
        parsed_response = parse_response(response)
        expect(unauthorized.id).to match(parsed_response[:id])
        expect(unauthorized.username).not_to match(parsed_response[:username])
      end
    end

    context 'as non-admin' do
      before { request.headers['Authorization'] = "Bearer #{get_token(unauthorized)}" }

      it 'should be able to update self' do
        put :update, params: {
          id: unauthorized.id,
          username: Faker::Internet.username,
          password: unauthorized.password,
          email: unauthorized.email
        }

        expect(response.status).to eq(202)
        parsed_response = parse_response(response)
        expect(unauthorized.id).to match(parsed_response[:id])
        expect(unauthorized.username).not_to match(parsed_response[:username])
      end

      it 'should not be able to update other users' do
        put :update, params: {
          id: authorized.id,
          username: Faker::Internet.username,
          password: authorized.password,
          email: authorized.email
        }

        expect(response.status).to eq(401)
      end
    end

    it 'should error out with invalid data' do
      post :update, params: { id: authorized.id, password: '123456789', admin: 'wrong' }

      expect(response.status).to eq(422)
    end
  end

  describe 'DELETE /destroy' do
    before { request.headers['Authorization'] = "Bearer #{get_token(authorized)}" }

    it 'should delete user if admin' do
      users_count = User.all.length
      delete :destroy, params: { id: unauthorized.id }

      expect(response.status).to eq(200)
      expect(users_count).to be > User.all.length
    end

    it 'should not allow admins to get deleted' do
      delete :destroy, params: { id: authorized.id }

      expect(response.status).to eq(401)
    end

    it 'should not allow non-admins to delete any users' do
      request.headers['Authorization'] = "Bearer #{get_token(unauthorized)}"
      delete :destroy, params: { id: unauthorized.id }

      expect(response.status).to eq(401)
    end
  end
end
