Rails.application.routes.draw do
  root 'settings#index'

  get 'destroy/sessions' => 'sessions#destroy'

  resources :sessions, only: [:new, :create]
  resources :users, only: [:new, :create]
  resources :settings, only: [:index]
end
