module Settings
  class RegistrationsController < ApplicationController
    before_filter :redirect_to_new_session
    before_filter :define_registration
    before_filter :check_creating_company_step, only: [:new]

    def new
      @incorporation_forms = get_incorporation_forms
      @koatuu              = []
    end

    def create
      registration = current_user.companies.last.create_registration registration_params

      if !(registration.valid? && registration.save)
        flash[:error] = t('validation.errors.invalid_data')
      else
        flash[:error] = nil
      end
    end

    def update
      registration = Registration.find(params['id'])
      respond_to do |format|
        if registration.update(registration_params)
            format.json { head :no_content } if params[:page]
            format.js unless params[:page]
        else
          if params[:page]
            format.json { render json: @registration.errors, status: :unprocessable_entity }
          else
            flash[:error] = t('validation.errors.invalid_data')
            format.js
          end
        end
      end
    end

    def get_koatuu
      koatuus = Koatuu.by_code_and_name params[:q]
      render json: { data: koatuus }
    end

    private

    def registration_params
      params.require(:registration).permit(:form_of_incorporation,
                                           :edrpou,
                                           :nace_codes,
                                           :koatuu,
                                           :risk_class,
                                           :pdv,
                                           :tin,
                                           :state_registration_date,
                                           :registration_number,
                                           :registered_by,
                                           :date_registered_in_revenue_commissioners,
                                           :number_registered_in_revenue_commissioners,
                                           :registered_in_pension_fund,
                                           :code_registered_in_pension_fund,
                                           :tax_system,
                                           :tax_inspection
                                          )
    end

    def get_incorporation_forms
      IncorporationForm.all
                       .order('name asc')
                       .collect do |f|
                         [ f.number_name, f.number_name ]
                       end
    end

    def define_registration
      @registration ||= Registration.new
    end
  end
end
