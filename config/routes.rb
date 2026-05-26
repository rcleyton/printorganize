Rails.application.routes.draw do
  root "site#index"

  get  "/signup", to: "users#new"
  post "/signup", to: "users#create"

  resource :session
  resources :passwords, param: :token
  
  get "up" => "rails/health#show", as: :rails_health_check
end
