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
    mount RailsAdmin::Engine => '/administrator', as: 'rails_admin'
    authenticated :user do
      root 'portals#role_router', as: :authenticated_root

      get 'welcome', to: 'pages#onboarding', as: 'onboarding'

      get 'participant', to: 'participant_portal#index', as: 'participant_portal'
      get 'dispensary', to: 'dispensary_portal#index', as: 'dispensary_portal'
      get 'doctor', to: 'doctor_portal#index', as: 'doctor_portal'
      get 'researcher', to: 'researcher_portal#index', as: 'researcher_portal'

      get 'map', to: 'home#map', as: :map
      get 'dispensary/transfers', to: 'dispensary_portal#transfers', as: 'transfers'
      get 'dispensary/transfers_report', to: 'dispensary_portal#transfers_report', as: 'report'
      get 'stock', to: 'dispensary_portal#stock', as: 'stock'
      get 'warehouse_stock', to: 'dispensary_portal#warehouse'
      get 'order', to: 'dispensary_portal#order'
      get 'dispensary_search', to: 'dispensary_portal#search'
      get 'dispensary_participant', to: 'dispensary_portal#participant'
      get 'material_choice', to: 'dispensary_portal#material_choice'
      get 'transfer', to: 'dispensary_portal#transfer'
      get 'finalize_transfer', to: 'dispensary_portal#finalize'
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

