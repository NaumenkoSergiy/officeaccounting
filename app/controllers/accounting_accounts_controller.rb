class AccountingAccountsController < ApplicationController
  before_filter :redirect_to_new_session
  before_action :accounting_accounts, only: [:index, :create]
  before_action :accounting_account, only: [:index, :create]
  before_action :find_accounting_account, only: [:show, :update, :destroy]

  def index
    respond_to do |format|
      format.js
      format.json do
        json = AccountingAccount.select(:id, :account_number).map { |a| { id: a.id, account_number: a.account_number.to_s } }
        render json: json.sort_by{ |a| a[:account_number] }
      end
    end
  end

  def show
    @children = @accounting_account.children
    render layout: false
  end

  def create
    @accounting_account.update_attributes accounting_accounts_params
    if @accounting_account.save
      @accounting_account.update_directory_field(true) if params[:accounting_account][:parent_id]
    else
      flash.now[:error] = t('validation.errors.account_error')
    end
    respond_to  { |format| format.js }
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
    if @accounting_account.account_parent? && @accounting_account.children_size == 0
      @accounting_account.update_directory_field(false)
    end
    respond_to  { |format| format.js }
  end

  private

  def accounting_account
    @accounting_account = AccountingAccount.new
  end

  def find_accounting_account
    @accounting_account = AccountingAccount.find(params[:id])
  end

  def accounting_accounts_params
    params.require(:accounting_account).permit!
  end

  def accounting_accounts
    @accounting_accounts = AccountingAccount.roots.page(params[:page])
  end
end
