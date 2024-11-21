Rails.application.routes.draw do
  get 'bookings/index'
  get 'bookings/new'
  get 'bookings/create'
  get 'bookings/show'
  get 'bookings/destroy'
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
