module Settings
  class BankAccountsController < ApplicationController
    before_filter :redirect_to_new_session
    before_filter :define_bank_account

    def create
      flash[:error] = 'Помилкові дані' unless @bank_account.update_attributes(bank_account_params)
    end

    private

    def bank_account_params
      params.require(:bank_account).permit(:account, :bank, :mfo)
    end

    def define_bank_account
      @bank_account ||= current_user.companies.last.create_bank_account
    end
  end
end
