Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  root 'settings#index'

  get 'destroy/sessions' => 'sessions#destroy'
  get 'users/confirm_registration'

  resources :sessions, only: [:new, :create]
  resources :users, only: [:new, :create]
  resources :settings, only: [:index]
  resources :counterparties
  resources :registers

  namespace 'settings' do
    resources :companies, only: [:new, :create]
    resources :registrations, only: [:new, :create]
    resources :officials, only: [:new, :create]
    resources :bank_accounts, only: [:create]

    post 'companies/add_existing_company'
  end
end
