require 'sidekiq/web'

Rails.application.routes.draw do
  get 'profiles/show'
  get 'profiles/update'
  devise_for :users

  mount Sidekiq::Web => "/sidekiq"

  root 'hi_world#index'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"


  
  resources :movies do
    collection do
      get :omdb_search
      post :omdb_import
    end
    resources :comments, only: %i[create edit update destroy]
  end

  resource :profile, only: %i[edit update], controller: :profiles
end
