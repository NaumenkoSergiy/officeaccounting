class RegistersController < ApplicationController
  before_action :set_register, only: [:edit, :update, :destroy]
  before_filter :redirect_to_new_session
  before_filter :has_company?, only: [:index, :new]

  def index
    @registers = Register.all
  end

  def new
    @register = Register.new
    @counterparty = Counterparty.all
  end

  def edit
    @counterparty = Counterparty.all
  end

  def create
    @register = Register.new(register_params)
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
        format.html { redirect_to registers_url }
      else
        format.html { render :edit }
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

