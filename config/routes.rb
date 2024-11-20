Rails.application.routes.draw do
  # Root
  root to: "wigs#index"

  # Devise (users)
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users, only: [:show]

  # Wigs
  resources :wigs

  # Reviews
  get 'reviews/new'
  get 'reviews/create'
  get 'reviews/index'
end
