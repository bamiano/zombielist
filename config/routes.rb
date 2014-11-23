Rails.application.routes.draw do

  ### ACCESS + MAIN ROUTES
  root 'access#login'

  get '/home', to: 'access#home'

  get '/', to: 'access#login', as: 'log'

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


# rake routes
#             Prefix Verb   URI Pattern                                  Controller#Action
#               root GET    /                                            access#login
#               home GET    /home(.:format)                              access#home
#                    GET    /                                            access#login
#              index GET    /index(.:format)                             access#login
#        create_user POST   /signup(.:format)                            access#create
#             signup GET    /signup(.:format)                            access#new
#              login GET    /login(.:format)                             access#login
#                    POST   /login(.:format)                             access#attempt_login
#             logout GET    /logout(.:format)                            access#logout
#             forgot GET    /forgot(.:format)                            access#forgot_password
#         send_reset POST   /send_reset(.:format)                        access#send_reset
#              reset GET    /reset/:token(.:format)                      access#reset_password
#    update_password POST   /update_password(.:format)                   access#update_password
#     user_favorites GET    /users/:user_id/favorites(.:format)          favorites#index
#                    POST   /users/:user_id/favorites(.:format)          favorites#create
#  new_user_favorite GET    /users/:user_id/favorites/new(.:format)      favorites#new
# edit_user_favorite GET    /users/:user_id/favorites/:id/edit(.:format) favorites#edit
#      user_favorite GET    /users/:user_id/favorites/:id(.:format)      favorites#show
#                    PATCH  /users/:user_id/favorites/:id(.:format)      favorites#update
#                    PUT    /users/:user_id/favorites/:id(.:format)      favorites#update
#                    DELETE /users/:user_id/favorites/:id(.:format)      favorites#destroy
#     user_locations GET    /users/:user_id/locations(.:format)          locations#index
#                    POST   /users/:user_id/locations(.:format)          locations#create
#  new_user_location GET    /users/:user_id/locations/new(.:format)      locations#new
# edit_user_location GET    /users/:user_id/locations/:id/edit(.:format) locations#edit
#      user_location GET    /users/:user_id/locations/:id(.:format)      locations#show
#                    PATCH  /users/:user_id/locations/:id(.:format)      locations#update
#                    PUT    /users/:user_id/locations/:id(.:format)      locations#update
#                    DELETE /users/:user_id/locations/:id(.:format)      locations#destroy
#              users GET    /users(.:format)                             users#index
#                    POST   /users(.:format)                             users#create
#           new_user GET    /users/new(.:format)                         users#new
#          edit_user GET    /users/:id/edit(.:format)                    users#edit
#               user GET    /users/:id(.:format)                         users#show
#                    PATCH  /users/:id(.:format)                         users#update
#                    PUT    /users/:id(.:format)                         users#update
#                    DELETE /users/:id(.:format)                         users#destroy
#              items GET    /items(.:format)                             items#index
#                    POST   /items(.:format)                             items#create
#           new_item GET    /items/new(.:format)                         items#new
#          edit_item GET    /items/:id/edit(.:format)                    items#edit
#               item GET    /items/:id(.:format)                         items#show
#                    PATCH  /items/:id(.:format)                         items#update
#                    PUT    /items/:id(.:format)                         items#update
#                    DELETE /items/:id(.:format)                         items#destroy