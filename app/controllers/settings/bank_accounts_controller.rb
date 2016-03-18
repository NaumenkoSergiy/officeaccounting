module Settings
  class BankAccountsController < ApplicationController
    before_action :redirect_to_new_session
    before_action :define_bank_account, only: [:create]
    before_action :set_bank_account, only: [:update, :new]

    def create
      flash[:error] = t('validation.errors.invalid_data') unless @bank_account.update_attributes(bank_account_params)
    end

    def update
      bank_account = BankAccount.find(params['id'])
      respond_to do |format|
        if bank_account.update(bank_account_params)
          format.json { head :no_content }
        else
          format.json { render json: bank_account.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def bank_account_params
      params.require(:bank_account).permit(:account, :bank_id, :mfo)
    end

    def define_bank_account
      @bank_account ||= current_user.companies.last.create_bank_account
    end

    def set_bank_account
      @bank_account = if params[:id]
                        BankAccount.find(params['id'])
                      else
                        BankAccount.new
                      end
    end
  end
end
