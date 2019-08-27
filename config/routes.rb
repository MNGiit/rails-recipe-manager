Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'home'
  root 'application#home'
  # get '/login', to: 'application#login'
  # post '/login', to: 'application#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :users, only: [:index, :new, :create, :edit, :show] do
    resources :recipes, only: [:new, :create, :edit, :update]
  end

  resources :recipes, only: [:index, :show, :destroy]
  # resources :users
  # get '/users', to: 'users#index'
end
