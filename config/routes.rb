Rails.application.routes.draw do
  root to: "wigs#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :wigs
end
