module Money
  class AccountsController < ApplicationController
    before_filter :redirect_to_new_session
    before_action :set_account, only: [:destroy, :update, :show]
    before_action :define_account, only: [:index, :new]
    before_action :company_account, only: [:index, :create]

    def index
      if params[:page]
        accounts = @accounts.map { |account| { value: account.id, text: account.number.to_s } }
        render json: accounts, status: 200
      else
        respond_to do |format|
          format.js
        end
      end
    end

    def new
      respond_to do |format|
        format.js
      end
    end

    def show
      respond_to do |format|
        format.js
      end
    end

    def create
      @account = Account.new account_params
      flash[:error] = t('validation.errors.invalid_data') unless @account.save
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
      @account.destroy
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
      @account ||= Account.new
    end

    def company_account
      @accounts = current_user.accounts.order('accounts.created_at DESC')
    end
  end
end
