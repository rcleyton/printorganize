Rails.application.routes.draw do
  root "site#index"

  get  "/signup",    to: "users#new"
  post "/signup",    to: "users#create"

  get "/calculator", to: "calculator#index"

  resource :session
  resources :passwords, param: :token

  namespace :dashboard do
    get "/home", to: "home#index"

    resources :printers
    resources :filaments
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
