Rails.application.routes.draw do
  root to: "wigs#index"
  devise_for :users
  resources :wigs, only:[:index, :show, :new, :create]
end
