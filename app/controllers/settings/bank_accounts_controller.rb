module Settings
  class BankAccountsController < ApplicationController
    before_filter :redirect_to_new_session

    def create
      if current_user.companies.last.officials.empty?
        redirect_to new_settings_official_path
      else
        current_user.companies.last.create_bank_account bank_account_params
        render :nothing => true, :status => 200
      end
    end

    private

    def bank_account_params
      params.permit(:account,
                    :bank,
                    :mfo)
    end
  end
end
