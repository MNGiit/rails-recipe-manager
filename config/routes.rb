Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'home'
  root 'application#home'
  # get '/login', to: 'application#login'
  # post '/login', to: 'application#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :users, only: [:index, :new, :edit, :show] do
    resources :recipes, only: [:new, :create, :edit]
  end

  resources :recipes, only: [:index, :show]
  # resources :users
  # get '/users', to: 'users#index'
end
