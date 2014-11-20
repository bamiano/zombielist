Rails.application.routes.draw do

  ### ACCESS + MAIN ROUTES
  root 'access#login'

  get '/', to: 'access#login'

  get 'index', to: 'access#login'

  post 'signup', to: 'access#create', as: 'create_user'

  get 'signup', to: 'access#new'

  get 'login', to: 'access#login', as: 'login'

  post 'login', to: 'access#attempt_login'

  get 'logout', to: 'access#logout'

# resource routes for user, plus locaitons and items within users

  resources :users do
    resources :favorites
    resources :locations
  end

  resources :items
  
end
