module Purchases
  class NomenclaturesController < ApplicationController
    before_action :redirect_to_new_session
    before_action :find_nomenclature, only: [:destroy, :update]
    before_action :all_nomenclatures, only: [:index, :create]
    before_action :define_nomenclature, only: [:index, :create]
    before_action :subclasses_of_nomenclature, only: :index

    def index
      if params[:paginate]
        render partial: 'purchases/nomenclatures/paginate'
      else
        respond_to do |format|
          format.js
          format.html { render layout: false }
        end
      end
    end

    def create
      @nomenclature.update(nomenclatures_params)
      flash.now[:error] = t('validation.errors.all_fields') unless @nomenclature.save
      respond_to { |format| format.js }
    end

    def update
      respond_to do |format|
        if @nomenclature.update(nomenclatures_params)
          format.json { head :no_content }
        else
          format.json { render json: @nomenclature.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      flash.now[:error] = t('validation.errors.delete_error') unless @nomenclature.destroy
      respond_to { |format| format.js }
    end

    private

    def define_nomenclature
      @nomenclature = Nomenclature.new
    end

    def find_nomenclature
      @nomenclature = Nomenclature.find(params[:id])
    end

    def nomenclatures_params
      params.require(:nomenclature).permit!.merge(company_id: current_company.id)
    end

    def all_nomenclatures
      @nomenclatures = current_company.nomenclatures.by_type(params[:type])
                                      .page(params[:page])
    end

    def subclasses_of_nomenclature
      @subclasses = Nomenclature.subclasses
    end
  end
end
