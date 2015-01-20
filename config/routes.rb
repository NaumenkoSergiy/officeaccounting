Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  root 'settings#index'

  get 'destroy/sessions' => 'sessions#destroy'
  get 'users/confirm_registration'
  get 'settings/registrations/get_koatuu'
  post 'users/create_delegate'
  post 'settings/companies/change_company'

  resources :sessions, only: [:new, :create]
  resources :users, only: [:new, :create]
  resources :settings, only: [:index, :show]
  resources :counterparties
  resources :registers
  resources :password_resets
  resources :money, only: [:index]

  namespace 'settings' do
    resources :companies, only: [:new, :create, :update]
    resources :registrations, only: [:new, :create, :update]
    resources :officials, only: [:new, :create, :update]
    resources :bank_accounts, only: [:new, :create, :update]

    post 'companies/add_existing_company'
  end

  namespace 'money' do
    resources :currencies, only: [:create, :destroy]
    resources :banks
    resources :credits
    resources :accounts
    resources :cashiers
    resources :articles
  end
end
