Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  root 'settings#index'

  get 'destroy/sessions' => 'sessions#destroy'
  get 'users/confirm_registration'
  get 'settings/registrations/get_koatuu'
  get 'settings/companies/change_company'
  get 'sessions/set_language'

  resources :sessions, only: [:new, :create]
  resources :users, only: [:new, :create]
  resources :settings, only: [:index, :show]
  resources :password_resets
  resources :money, only: [:index]
  resources :delegates, only: [:create, :destroy, :update]
  resources :sales, only: [:index]
  resources :purchases, only: [:index]
  resources :contracts
  
  namespace 'settings' do
    resources :companies, only: [:new, :create, :update]
    resources :registrations, only: [:new, :create, :update]
    resources :officials, only: [:new, :create, :update]
    resources :bank_accounts, only: [:new, :create, :update]

    post 'companies/add_existing_company'
  end

  namespace 'money' do
    resources :currencies
    resources :banks
    resources :credits
    resources :accounts
    resources :cashiers
    resources :articles
    resources :registers
    resources :exchange_rates
  end

  namespace 'purchases' do
    resources :counterparties
  end

  get '*path', to: 'application#page_not_found'
end
