# frozen_string_literal: true

Rails.application.routes.draw do
  resources :answers
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
      get 'info', to: 'pages#info', as: 'info'

      # Participant Related Routes
      get 'steps', to: 'participant_portal#steps', as: 'steps'
      get 'consent', to: 'participant_portal#consent', as: 'consent'
      get 'agree', to: 'participant_portal#agree', as: 'agree'
      get 'participant', to: 'participant_portal#index', as: 'participant_portal'
      get 'participant/surveys', to: 'participant_portal#surveys', as: 'participant_surveys'
      get 'participant/surveys/:id', to: 'participant_portal#fill_survey', as: 'fill_survey'
      patch 'survey/:id', to: 'filled_surveys#update', as: 'update_filled_survey'
      get 'steps/pay/process', to: 'participant_portal#process_payment', as: 'process_payment'
      get 'steps/book', to: 'participant_portal#book', as: 'book_appointment'

      # Doctor Related Routes
      get 'doctor', to: 'doctor_portal#index', as: 'doctor_portal'
      get 'doctor/appointments', to: 'doctor_portal#appointments', as: 'appointments'
      get 'doctor/calendar', to: 'doctor_portal#calendar', as: 'calendar'
      get 'doctor/evaluations', to: 'doctor_portal#evaluations', as: 'evaluations'

      # Researcher Related Routes
      get 'researcher', to: 'researcher_portal#surveys', as: 'researcher_portal'
      get 'researcher/survey/:survey', to: 'researcher_portal#survey_edit', as: 'survey_edit_dashboard'
      resources :surveys
      delete 'survey/:id', to: 'surveys#hide', as: 'hide_survey'
      post 'survey/add', to: 'researcher_portal#add_survey', as: 'add_survey'
      get 'researcher/survey/:survey/questions', to: 'researcher_portal#show_questions', as: 'show_questions'
      post 'survey/:survey/questions/add', to: 'researcher_portal#add_question', as: 'add_question'
      delete 'question/:id', to: 'researcher_portal#remove_question', as: 'remove_question'
      post 'questions/new/:survey', to: 'researcher_portal#add_question', as: 'new_question'
      patch 'question/:id/update', to: 'researcher_portal#update_question', as: 'update_question'
      post 'question/:id/add_option', to: 'researcher_portal#add_option', as: 'add_option'
      delete 'option/:id', to: 'researcher_portal#remove_option', as: 'remove_option'

      get 'map', to: 'home#map', as: :map

      # Dispensary Related Routes
      get 'dispensary', to: 'dispensary_portal#index', as: 'dispensary_portal'
      get 'dispensary/transfers', to: 'dispensary_portal#transfers', as: 'transfers'
      get 'stock', to: 'dispensary_portal#stock', as: 'stock'
      get 'warehouse_stock', to: 'dispensary_portal#warehouse'
      get 'order', to: 'dispensary_portal#order'
      get 'dispensary_search', to: 'dispensary_portal#search'
      get 'dispensary_participant', to: 'dispensary_portal#participant'
      get 'material_choice', to: 'dispensary_portal#material_choice'
      get 'transfer', to: 'dispensary_portal#transfer'
      get 'finalize_transfer', to: 'dispensary_portal#finalize'
      get 'dispensary/report', to: 'dispensary_portal#report', as: 'report'
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
  get '*path' => redirect('/')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

