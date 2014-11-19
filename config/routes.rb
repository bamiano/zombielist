Rails.application.routes.draw do

  ### ACCESS + MAIN ROUTES
  root 'access#login'

  get '/', to: 'access#login'

  get 'index', to: 'access#login'

  post 'signup', to: 'access#create', as: 'create_user'

  get 'signup', to: 'access#new'

  get 'home', to: 'users#index'

  get 'login', to: 'access#login', as: 'login'

  get 'logout', to: 'access#logout'

  post 'login', to: 'access#attempt_login'

# resource routes for user, plus locaitons and items within users

  resources :users do
    resources :favorites
    resources :locations
  end

  resources :items
  
end
