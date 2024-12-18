Rails.application.routes.draw do
  # Root
  root to: "wigs#index"

  # Bookings
  get 'bookings/index'
  get 'bookings/new'
  get 'bookings/create'
  get 'bookings/show'
  get 'bookings/destroy'

  # Devise (users)
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users, only: [:show]

  # Wigs
  resources :wigs do
      resources :bookings, only: [:create]
  end

  resources :bookings, only: [:index, :new, :show, :destroy]


  # Reviews
  get 'reviews/new'
  get 'reviews/create'
  get 'reviews/index'
end
