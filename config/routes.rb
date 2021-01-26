Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions'
  }
  resources :users, only: [:show, :index] # WE dont need that - just for PoC 
  resource :user, only: [:edit, :update]
  get 'home/index'
  root 'home#index'
  get 'under_construction', to: 'home#under_construction'
  get 'blog', to: 'home#index'
  get 'map', to: 'home#map', as: :map
  get ':id', to: 'pages#show', as: :page
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
