class GuideUnitsController < ApplicationController
  before_action :redirect_to_new_session
  before_action :find_guide_unit, only: [:destroy, :update]
  before_action :guide_units, only: [:index, :create]
  before_action :define_guide_unit, only: [:index, :create]

  def index
    respond_to do |format|
      format.js
      format.json do
        render json: @guide_units.select(:id, :name)
          .map { |guide_unit| { value: guide_unit.id, text: guide_unit.name } }, status: 200
      end
    end
  end

  def create
    @guide_unit.update_attributes guide_unit_params
    flash.now[:error] = t('validation.errors.all_fields') unless @guide_unit.save
    respond_to { |format| format.js }
  end

  def update
    respond_to do |format|
      if @guide_unit.update(guide_unit_params)
        format.json { head :no_content }
      else
        format.json { render json: @guide_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @guide_unit.destroy
    respond_to { |format| format.js }
  end

  private

  def define_guide_unit
    @guide_unit = GuideUnit.new
  end

  def find_guide_unit
    @guide_unit = GuideUnit.find(params[:id])
  end

  def guide_unit_params
    params.require(:guide_unit).permit!.merge(user_id: current_user.id)
  end

  def guide_units
    @guide_units = current_user.guide_units.order('guide_units.created_at DESC')
  end
end
