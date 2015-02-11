class ContractsController < ApplicationController
  before_filter :redirect_to_new_session
  before_action :set_contract, only: [:destroy, :update]
  before_action :company_contract, only: [:index, :create]

  def index
    @contract = Contract.new
    respond_to do |format|
      format.js
    end  
  end

  def create
    @articles = Article.all
    @accounts ||= current_user.current_company.try(:accounts)
    @register = MoneyRegister.new
    @contract = Contract.new contract_params
    flash[:error] = 'Ви ввели не коректні данні' unless @contract.save
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @contract.update(contract_params)
        format.json { head :no_content }
      else
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contract.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def set_contract
    @contract = Contract.find(params[:id])
  end

  def contract_params
    params.require(:contract).permit(:date,
                                    :number,
                                    :contract_type,
                                    :validity,
                                    :counterparty_id).merge!(company_id: current_user.current_company.id)
  end

  def company_contract
    @contracts = current_user.current_company.contracts.order('contracts.created_at DESC')
    @counterparties = current_user.current_company.counterparties.order('counterparties.created_at DESC')
    @contracts_counterparty = @counterparties.empty? ? {} : Contract.contracts_for_conterparty(@counterparties.first.id)
  end
end
