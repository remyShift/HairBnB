Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/create'
  get 'reviews/index'
  root to: "wigs#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :wigs
end
