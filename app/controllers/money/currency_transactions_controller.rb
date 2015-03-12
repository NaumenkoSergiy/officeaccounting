module Money
  class CurrencyTransactionsController < ApplicationController
    before_filter :redirect_to_new_session
    before_filter :define_currency_transaction, only: [:new, :create]
    before_filter :currency_transactions, only: [:new, :create]
    before_filter :find_currency_transaction, only: :destroy

    def index
      respond_to { |format| format.js }
    end

    def new
      respond_to { |format| format.js }
    end

    def create
      @currency_transaction.update_attributes currency_transaction_params
      flash.now[:error] = t('validation.errors.all_fields') unless @currency_transaction.save
      respond_to { |format| format.js }
    end

    def destroy
      @curency_transaction.destroy
      respond_to { |format| format.js }
    end

    private

    def find_currency_transaction
      @curency_transaction = CurrencyTransaction.find(params[:id])
    end

    def define_currency_transaction
      @currency_transaction = CurrencyTransaction.new
    end

    def currency_transaction_params
      params.require(:currency_transaction).permit!.merge(company_id: current_company.id)
    end

    def currency_transactions
      company_currency_transactions = current_user.currency_transactions.order('currency_transactions.created_at DESC')
      @currency_transactions = company_currency_transactions.by_type(params[:type] || params[:currency_transaction][:type])
    end
  end
end
