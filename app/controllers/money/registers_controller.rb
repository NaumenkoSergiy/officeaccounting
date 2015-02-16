module Money  
  class RegistersController < ApplicationController
    before_filter :redirect_to_new_session
    before_action :set_register, only: [:update, :destroy]

    def new
      @register = MoneyRegister.new
      respond_to do |format|
        format.js
      end
    end

    def create
      @contract = Contract.new
      @register = MoneyRegister.new register_params
      @registers = current_user.money_registers.order('money_registers.created_at DESC')
      flash.now[:error] = t('validation.errors.all_fields') unless @register.save
      respond_to do |format|
        format.js
      end
    end

    def update
      respond_to do |format|
        if @register.update(register_params)
          format.json { head :no_content }
        else
          format.json { render json: @register.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @register.destroy
      respond_to do |format|
        format.js
      end
    end

    private

    def set_register
      @register = MoneyRegister.find(params[:id])
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
  end
end
