module Settings
  class OfficialsController < ApplicationController
    def new
      redirect_to new_settings_company_path if current_user.companies.present? &&
                                                  current_user.companies.last.registration &&
                                                  current_user.companies.last.officials.present?
    end

    def create
      official = current_user.companies.last.officials.new officials_params

      if official.valid? && official.save
        render json: true
      else
        render json: false
      end
    end

    private

    def officials_params
      params.permit(:type, :name, :tin, :phone, :email)
    end
  end
end
