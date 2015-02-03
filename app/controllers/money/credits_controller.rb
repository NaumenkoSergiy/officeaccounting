module Money  
  class CreditsController < ApplicationController
    before_filter :redirect_to_new_session
    before_action :set_credit, only: [:destroy, :update]
    before_action :define_credit, only: [:index, :create]
    before_action :get_all_credits, only: [:index, :create]

    def index
      respond_to do |format|
        format.js
      end
    end

    def show
      @credit = Credit.find(params[:id])
      respond_to do |format|
        format.js
      end
    end

    def create
      if @credit.update_attributes(credit_params)
        @credits.push @credit
      else  
        flash[:error] = t('validation.errors.invalid_data')
      end
      respond_to do |format|
        format.js
      end
    end

    def update
      respond_to do |format|
        if @credit.update(credit_params)
          @credits = current_user.current_company.try(:credits)
          format.json { head :no_content }
        else
          format.json { render json: @credit.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      credit = Credit.find(params[:id])
      credit.destroy
      respond_to do |format|
        format.js
      end
    end

    private

    def credit_translate
      @credit_hash = Hash.new()
      Credit::CREDIT_TYPE.each do |key, value|
        @credit_hash[t(key)] = value
      end
      @credit_hash
    end

    def credit_params
      params.require(:credit).permit!
    end

    def set_credit
      @credit = Credit.find(params[:id])
    end

    def define_credit
      @credit ||= current_user.current_company.credits.new
    end

    def get_all_credits
      @credits ||= current_user.current_company.try(:credits) || []
    end
  end
end
