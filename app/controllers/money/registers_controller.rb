module Money  
  class RegistersController < ApplicationController
    before_filter :redirect_to_new_session
    before_action :define_cost, only: [:index, :create]
    before_action :set_register, only: [:update, :destroy]
    before_filter :has_company?, only: [:index]
    before_action :get_all_register, only: [:index, :create]

    def index
      @contracts = @counterparties.empty? ? {} : Contract.contracts_for_conterparty(@counterparties.first.id)
      respond_to do |format|
        format.js
      end
    end

    def create
      @contract = Contract.new
      @register = MoneyRegister.new register_params
      flash[:error] = 'Ви ввели не коректні данні' unless @register.save
      respond_to do |format|
        format.js
      end
    end

    def update
      respond_to do |format|
        if @counterparty.update(counterparty_params)
          format.json { head :no_content }
        else
          format.json { render json: @counterparty.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @register.destroy
      respond_to do |format|
        format.js
      end
    end

    def get_all_contract
      @contracts = Contract.contracts_for_conterparty(params[:counterparty_id])
      respond_to do |format|
        format.js
      end
    end

    private

    def set_register
      @register = MoneyRegister.find(params[:id])
    end

    def define_cost
      @register = MoneyRegister.new
    end

    def register_params
      params.require(:money_register).permit(:date,
                                             :type_document,
                                             :total,
                                             :counterparty_id,
                                             :account_id,
                                             :contract_id,
                                             :article_id,
                                             :type_money).merge!(company_id: current_user.current_company.id)
    end
    
    def get_all_register
      @articles = Article.all
      @banks = Bank.all
      @accounts ||= current_user.current_company.try(:accounts)
      @counterparties ||= current_user.current_company.try(:counterparties)
      @registers = current_user.current_company.money_registers.order('money_registers.created_at DESC').limit(7)
    end
  end
end
