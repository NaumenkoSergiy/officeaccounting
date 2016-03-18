module Personnels
  class PositionsController < ApplicationController
    before_action :redirect_to_new_session
    before_action :find_position, only: [:destroy, :update]
    before_action :positions, only: [:index, :create]
    before_action :new_position, only: [:index, :create]

    def index
      respond_to do |format|
        format.js
        format.json do
          render json: @positions.select(:id, :title)
            .map { |position| { value: position.id, text: position.title } }, status: 200
        end
      end
    end

    def create
      @position.update(position_params)
      flash.now[:error] = t('validation.errors.all_fields') unless @position.save
      respond_to { |format| format.js }
    end

    def update
      respond_to do |format|
        if @position.update(position_params)
          format.json { head :no_content }
        else
          format.json { render json: @position.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      if @position.assigned?
        flash.now[:error] = t('validation.errors.position_error')
      else
        @position.destroy
      end
      respond_to { |format| format.js }
    end

    private

    def new_position
      @position = Position.new
    end

    def find_position
      @position = Position.find(params[:id])
    end

    def position_params
      params.require(:position).permit!.merge(company_id: current_company.id)
    end

    def positions
      @positions = current_company.positions.order('positions.created_at DESC')
                                  .page(params[:page])
    end
  end
end
