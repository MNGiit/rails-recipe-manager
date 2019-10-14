Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'home'
  root 'application#home'
  # get '/login', to: 'application#login'
  # post '/login', to: 'application#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  # get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/github/callback' => 'sessions#create'
  # get '/login/auth/github/callback' => 'sessions#create'
  post '/reviews/new' => 'reviews#create'

  resources :users, only: [:index, :new, :create, :edit, :show] do
    resources :recipes, only: [ :index, :new, :create, :edit, :update]
  end

  resources :recipes, only: [:index, :show, :destroy] do
    resources :reviews, only: [:new, :create]
  end

  # resources :reviews

  # resources :users
  # get '/users', to: 'users#index'
end
