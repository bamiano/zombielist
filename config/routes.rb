Rails.application.routes.draw do

  ### ACCESS + MAIN ROUTES
  root 'access#login'

  get '/home', to: 'access#home'

  get '/', to: 'access#login'

  get 'index', to: 'access#login'

  post 'signup', to: 'access#create', as: 'create_user'

  get 'signup', to: 'access#new'

  get 'login', to: 'access#login', as: 'login'

  post 'login', to: 'access#attempt_login'

  get 'logout', to: 'access#logout'

# password reset

  get 'forgot', to: 'access#forgot_password'

  post 'send_reset', to: 'access#send_reset'

  get 'reset/:token', to: 'access#reset_password', as: 'reset'

  post 'update_password', to: 'access#update_password'


# resource routes for user, plus locaitons and items within users

  resources :users do
    resources :favorites
    resources :locations
  end

  resources :items

end
