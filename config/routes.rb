Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'home'
  root 'application#home'
  # get '/login', to: 'application#login'
  # post '/login', to: 'application#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  # post '/logout' => 'sessions#destroy'

  resources :users, only: [:index, :new, :edit, :show]
  # resources :users
  # get '/users', to: 'users#index'
end
