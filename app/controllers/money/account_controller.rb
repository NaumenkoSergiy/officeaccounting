module Money
  class AccountController < ApplicationController
    before_filter :redirect_to_new_session
    before_action :set_account, only: [:destroy, :update]

    def show
      @banks = Bank.all
      @account_select = money_select(Account::ACCOUNT)
      @currency_select = money_select(Currency::CURRENCY)
      @account = Account.find(params[:id])
      respond_to do |format|
        format.js
      end
    end

    def create
      account = Account.new account_params
      @accounts = Account.all
      flash[:error] = 'Ви ввели не коректні данні' unless account.save
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
      render json:{ success: account.destroy }
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

    def money_select (name)
      name.invert
                 .collect do |key, value|
                 {
                  value: "#{key}",
                  text:  "#{value}"
                 }
               end
    end
  end
end
