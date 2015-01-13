class RegistersController < ApplicationController
  before_action :set_register, only: [:edit, :update, :destroy]
  before_filter :redirect_to_new_session

  def index
    @registers = current_user.registers
    @counterparty = current_user.counterparties
    @select_conterparty = current_user.counterparties.pluck(:id, :name).to_h
  end

  def new
    @register = Register.new
    @counterparty = current_user.counterparties
  end

  def edit
    @counterparty = current_user.counterparties
  end

  def create
    @register = current_user.registers.new register_params
    respond_to do |format|
      if @register.save
        format.html { redirect_to registers_url}
      else
        format.html { render :new }
      end
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
    @register_id = params[:id]
    respond_to do |format|
      format.html { redirect_to registers_url }
      format.js
    end
  end

  private
    def set_register
      @register = Register.find(params[:id])
    end

    def register_params
      params.require(:register).permit(:date, :counterparty_id, :operations, :value, :holding, :notes)
    end
end
