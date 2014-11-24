Rails.application.routes.draw do
  root 'settings#index'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :settings, only: [:index]
end
