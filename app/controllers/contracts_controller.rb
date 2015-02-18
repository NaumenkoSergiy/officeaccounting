class ContractsController < ApplicationController
  before_filter :redirect_to_new_session
  before_action :set_contract, only: [:destroy, :update]
  before_action :company_contract, only: [:new, :create]

  def index
    counterparty_contracts = Contract.contracts_for_conterparty(params[:id])
    render json: counterparty_contracts.order('contracts.created_at DESC'), status: 200
  end

  def new
    @contract = Contract.new
    respond_to do |format|
      format.js
    end  
  end

  def create
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
    @contracts = current_user.contracts.order('contracts.created_at DESC')
    @counterparties = current_user.counterparties.order('counterparties.created_at DESC')
  end
end
