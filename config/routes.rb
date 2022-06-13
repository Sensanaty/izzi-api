# frozen_string_literal: true

Rails.application.routes.draw do
  post '/auth/login', to: 'authentication#login', defaults: { format: :json }

  resources :users, except: [:index], defaults: { format: :json }
end
