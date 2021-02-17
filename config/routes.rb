Rails.application.routes.draw do

  # login / logout
  # root to: "/login"
  get "/login", to: "users#login", as: "login"
  post "/handle_login", to: "users#handle_login"
  delete "/logout", to: "users#logout", as: "logout"

  get "/join/", to: "events#join", as: "join"
  post "/handle_join", to: "events#join"

  patch "/events/:id/complete", to: "events#complete", as: "complete_event"
  patch "/events/:id/undo_complete", to: "events#undo_complete", as: "undo_complete_event"

  get "/user", to: "users#show", as: "user"

  resources :expenses
  resources :attendances
  resources :events
  resources :users

  # get "/users/:id"
  

  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
