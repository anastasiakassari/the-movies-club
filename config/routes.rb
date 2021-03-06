Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#home"

  resources :movies

  resources :users, except: [:new]
  get "signup", to: "users#new"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  post "rate", to: "ratings#rate"
end
