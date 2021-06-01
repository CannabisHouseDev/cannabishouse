# frozen_string_literal: true

Rails.application.routes.draw do
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
    end

    root 'pages#landing'

    get 'welcome', to: 'pages#onboarding', as: 'onboarding'

    get 'participant', to: 'participant_portal#index', as: 'participant_portal'
    get 'dispensary', to: 'dispensary_portal#index', as: 'dispensary_portal'
    get 'doctor', to: 'doctor_portal#index', as: 'doctor_portal'
    get 'researcher', to: 'researcher_portal#index', as: 'researcher_portal'

    resources :posts
    resource :user, only: [:update]
    resources :users, only: %i[show index edit update destroy] do
      resources :addresses
      resources :profiles
    end

    get 'home/index'
    get 'under_construction', to: 'home#under_construction'
    get 'blog', to: 'posts#index'
    get 'map', to: 'home#map', as: :map
    get 'about', to: 'pages#about', as: 'about'
    get 'media', to: 'pages#media', as: 'media'
    get 'billing', to: 'dispensary_portal#billing', as: 'billing'
    get 'stock', to: 'dispensary_portal#stock', as: 'stock'
    get 'search', to: 'dispensary_portal#search', as: 'user_lookup'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
