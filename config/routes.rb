Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  root 'settings#index'

  get 'destroy/sessions' => 'sessions#destroy'
  get 'users/confirm_registration'
  get 'settings/registrations/get_koatuu'

  resources :sessions, only: [:new, :create]
  resources :users, only: [:new, :create]
  resources :settings, only: [:index]
  resources :counterparties
  resources :registers
  resources :password_resets

  namespace 'settings' do
    resources :companies, only: [:new, :create, :update]
    resources :registrations, only: [:new, :create, :update]
    resources :officials, only: [:new, :create, :update]
    resources :bank_accounts, only: [:new, :create]

    post 'companies/add_existing_company'
  end
end
