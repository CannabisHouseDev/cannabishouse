Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :pages
    resources :posts

    root to: "users#index"
  end
  
  resources :posts
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions'
  }
  
  resources :users, only: [:show, :index, :edit] do
    resources :addresses
  end
  resource :user, only: [:update]
  
  get 'home/index'
  root 'home#index'
  get 'under_construction', to: 'home#under_construction'
  get 'blog', to: 'posts#index'
  get 'map', to: 'home#map', as: :map
  get ':id', to: 'pages#show', as: :page
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
