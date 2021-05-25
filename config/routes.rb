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

    get 'participant', to: 'participant#index', as: 'participant'
    get 'dispensary', to: 'dispensary#index', as: 'dispensary'
    get 'doctor', to: 'doctor#index', as: 'doctor'
    get 'researcher', to: 'researcher#index', as: 'researcher'

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
    get ':id', to: 'pages#show', as: :page
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
