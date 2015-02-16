module Money
  class AccountsController < ApplicationController
    before_filter :redirect_to_new_session
    before_action :set_account, only: [:destroy, :update]
    before_action :define_account, only: [:index, :new, :create]
    before_action :company_account, only: [:index, :create]

    def index
      if params[:id]
        accounts = Account.where(company_id: params[:id])
        render json: { data: accounts.order('accounts.created_at DESC') }
      else
        @banks = Bank.all
        respond_to do |format|
          format.js
        end
      end
    end

    def new
      @banks = Bank.all
      respond_to do |format|
        format.js
      end
    end

    def show
      @banks = Bank.all
      @account = Account.find(params[:id])
      respond_to do |format|
        format.js
      end
    end

    def create
      account = Account.new account_params
      flash[:error] = t('validation.errors.invalid_data') unless account.save
      respond_to do |format|
        format.js
      end
    end

    def update
      respond_to do |format|
        if @account.update(account_params)
          format.json { head :no_content }
        else
          format.json { render json: @account.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      account = Account.find(params[:id])
      account.destroy
      respond_to do |format|
        format.js
      end
    end

    private

    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:name,
                                      :account_type,
                                      :number,
                                      :currency,
                                      :bank_id).merge!(company_id: current_user.current_company.id)
    end

    def define_account
      @register ||= MoneyRegister.new
      @account ||= Account.new
    end

    def company_account
      @accounts = current_user.accounts.order('accounts.created_at DESC')
    end
  end
end
