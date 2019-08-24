Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'home'
  root 'application#home'
  
  resources :users, only: [:index, :new, :create, :edit, :show]
  # resources :users
  # get '/users', to: 'users#index'
end
