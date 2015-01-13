class CounterpartiesController < ApplicationController
  before_action :set_counterparty, only: [:edit, :update, :destroy]
  before_filter :redirect_to_new_session

  def index
    @counterparties = current_user.counterparties
  end

  def new
    @counterparty = Counterparty.new
  end

  def edit
  end

  def create
    @counterparty = current_user.counterparties.new counterparty_params

    respond_to do |format|
      if @counterparty.save
        format.html { redirect_to counterparties_url }
      else
        format.html { render :new }
      end
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
    @counterparty.destroy
    @counterparty_id = params[:id]
    respond_to do |format|
      format.html { redirect_to counterparties_url }
      format.js
    end
  end

  private
    def set_counterparty
      @counterparty = Counterparty.find(params[:id])
    end

    def counterparty_params
      params.require(:counterparty).permit(:name, :start_date, :active)
    end
end

