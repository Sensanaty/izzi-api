# frozen_string_literal: true

Rails.application.routes.draw do
  post '/auth/login', to: 'authentication#login', defaults: { format: :json }
  get '/auth/authenticate', to: 'authentication#authenticate', defaults: { format: :json }
  get '/auth/user', to: 'authentication#user', default: { format: :json }

  resources :users, except: [:index], defaults: { format: :json }

  resources :parts, defaults: { format: :json } do
    member do
      get :versions
      delete :versions, action: :delete_versions
    end

    collection do
      get :export
    end
  end

  resources :companies, defaults: { format: :json } do
    member do
      get :parts, action: :parts
    end
  end
  resources :clients, defaults: { format: :json }

  post '/contact-us', to: 'form#create', defaults: { format: :json }
end
