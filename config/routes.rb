Rails.application.routes.draw do
  get ':id', to: 'pages#show', as: :page
  get 'home/index'
  root 'home#index'
  get 'under_construction', to: 'home#under_construction', as: :under_construction
  get 'blog', to: 'home#index'
  get 'map', to: 'home#map', as: :map
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
