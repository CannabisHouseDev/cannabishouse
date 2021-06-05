# frozen_string_literal: true

Rails.application.routes.draw do
  resources :transfers
  namespace :admin do
    resources :users
    resources :pages
    resources :posts

    root to: 'users#index'
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  scope '(:locale)', locale: /en/ do
    authenticated :user do
      root 'portals#role_router', as: :authenticated_root

      get 'welcome', to: 'pages#onboarding', as: 'onboarding'

      get 'participant', to: 'participant_portal#index', as: 'participant_portal'
      get 'dispensary', to: 'dispensary_portal#index', as: 'dispensary_portal'
      get 'doctor', to: 'doctor_portal#index', as: 'doctor_portal'
      get 'researcher', to: 'researcher_portal#index', as: 'researcher_portal'

      get 'map', to: 'home#map', as: :map
      get 'billing', to: 'dispensary_portal#billing', as: 'billing'
      get 'stock', to: 'dispensary_portal#stock', as: 'stock'
      get 'search', to: 'dispensary_portal#search', as: 'user_lookup'
      get 'trasnfer', to: 'dispensary_portal#transfer', as: 'dispensary_to_participant'
    end

    root 'pages#landing'

    get 'about', to: 'pages#about', as: 'about'
    get 'media', to: 'pages#media', as: 'media'

    resources :posts
    resource :user, only: [:update]
    resources :users, only: %i[show index edit update destroy] do
      resources :addresses
      resources :profiles
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

