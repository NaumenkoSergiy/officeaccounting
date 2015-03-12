module Money
  class RegistersController < ApplicationController
    before_filter :redirect_to_new_session
    before_action :set_register, only: [:update, :destroy]
    before_action :all_registers, only: [:index, :create]

    def index
      chart_data = @registers.group_by_month
      render json: chart_data, status: 200
    end

    def new
      @register = MoneyRegister.new
      respond_to do |format|
        format.js
      end
    end

    def create
      @register = MoneyRegister.new register_params
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

    def all_registers
      @search = current_user.money_registers.search params[:q]
      @registers = @search.result.page(params[:page])
      @search.build_condition if @search.conditions.empty?
      @search.build_sort if @search.sorts.empty?
    end
  end
end
