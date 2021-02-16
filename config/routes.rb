Rails.application.routes.draw do

  # login / logout
  # root to: "/login"
  get "/login", to: "users#login", as: "login"
  post "/handle_login", to: "users#handle_login"
  delete "/logout", to: "users#logout", as: "logout"

  patch "/events/:id/complete", to: "events#complete", as: "complete_event"

  resources :expenses
  resources :attendances
  resources :events
  resources :users

  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
