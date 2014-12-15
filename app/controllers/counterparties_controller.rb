class CounterpartiesController < ApplicationController
  before_action :set_counterparty, only: [:edit, :update, :destroy]
  before_filter :redirect_to_new_session
  before_filter :has_company?, only: [:index, :new]

  def index
    @counterparties = Counterparty.all
  end

  def new
    @counterparty = Counterparty.new
  end

  def edit
  end

  def create
    @counterparty = Counterparty.new(counterparty_params)

    respond_to do |format|
      if @counterparty.save
        format.html { redirect_to counterparties_path }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @counterparty.update(counterparty_params)
        format.html { redirect_to @counterparty }
        format.json { render :show, status: :ok, location: @counterparty }
      else
        format.html { render :edit }
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

