Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  ActiveAdmin.routes(self)
  scope '(:locale)', locale: /en|ua/ do
    root 'settings#index'
    get 'destroy/sessions' => 'sessions#destroy'
    get 'users/confirm_registration'
    get 'settings/registrations/koatuu'
    get 'settings/companies/change_company'
    get 'sessions/set_language'

    resources :messages, only: [:new, :create]

    resources :conversations, only: [:index, :show, :destroy] do
      member do
        post :reply
        post :forward
        post :restore
      end
      collection do
        delete :empty_trash
      end
    end
    resources :sessions, only: [:new, :create]
    resources :users, only: [:new, :create, :update] do
      collection do
        get :recipients
      end
    end
    resources :settings, only: [:index, :show]
    resources :password_resets
    resources :money, only: [:index] do
      collection { get :search, to: 'money#index' }
    end
    resources :delegates, only: [:create, :destroy, :update]
    resources :sales, only: [:index]
    resources :purchases, only: [:index]
    resources :contracts
    resources :accounting_accounts, except: :edit
    resources :guide_units, except: :edit
    resources :tool_equipments, only: :index
    resources :personnels, only: :index

    namespace 'settings' do
      resources :companies, only: [:new, :create, :update]
      resources :registrations, only: [:new, :create, :update]
      resources :officials, only: [:new, :create, :update]
      resources :bank_accounts, only: [:new, :create, :update]

      post 'companies/add_existing_company'
    end

    namespace 'money' do
      namespace :currency_transactions do
        resources :payment_orders
        resources :orders
      end
      resources :currencies
      resources :banks
      resources :credits
      resources :accounts
      resources :cashiers
      resources :articles
      resources :registers
      resources :exchange_rates
      resources :currency_transactions
    end

    namespace 'purchases' do
      resources :counterparties
      resources :nomenclatures, except: :edit
      resources :products
    end

    namespace 'tool_equipments' do
      resources :main_tools
    end

    namespace 'personnels' do
      resources :departments
      resources :positions
      resources :employees
    end
    resources :chat do
      collection do
        get :list
      end
      member do
        put :change_name
      end
    end
    resources :chat_messages
    get '*path', to: 'application#page_not_found'
  end
end
