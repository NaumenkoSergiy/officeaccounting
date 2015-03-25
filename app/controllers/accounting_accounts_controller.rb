class AccountingAccountsController < ApplicationController
  before_filter :redirect_to_new_session
  before_action :define_accounting_account, only: [:destroy, :update]
  before_action :accounting_accounts, only: [:index, :create]
  before_action :accounting_account, only: [:index, :create]

  def index
    respond_to do |format|
      format.js
    end
  end

  def create
    @accounting_account.update_attributes accounting_accounts_params
    flash.now[:error] = t('validation.errors.all_fields') unless @accounting_account.save
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @accounting_account.update(accounting_accounts_params)
        format.json { head :no_content }
      else
        format.json { render json: @accounting_account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    flash.now[:error] = t('validation.errors.delete_error') unless @accounting_account.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def accounting_account
    @accounting_account = AccountingAccount.new
  end

  def define_accounting_account
    @accounting_account = AccountingAccount.find(params[:id])
  end

  def accounting_accounts_params
    params.require(:accounting_account).permit!
  end

  def accounting_accounts
    @accounting_accounts = AccountingAccount.all
  end
end
