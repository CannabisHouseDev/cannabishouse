Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'
  get 'under_construction', to: 'home#under_construction'
  get 'blog', to: 'home#index'
  get 'map', to: 'home#map', as: :map
  get ':id', to: 'pages#show', as: :page
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
