# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :pages
    resources :posts
    resources :dispensaries

    root to: 'users#index'
  end
<<<<<<< HEAD
  resources :dispensaries do
    member do
      put :add_member
      put :remove_member
      get :members_list
    end
  end
  resources :posts
  
=======

>>>>>>> master
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  scope '(:locale)', locale: /en/ do
    root 'pages#landing'

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
