module Settings
  class OfficialsController < ApplicationController
    def create
      binding.pry
      official = current_user.companies.last.officials.new officials_params

      if official.valid? && official.save
        redirect_to settings_path
      else
        render json: false
      end
    end

    private

    def officials_params
      binding.pry
      params.require(:director).permit(:full_name,
                    :short_name,
                    :latin_name,
                    :juridical_address,
                    :actual_address,
                    :numbering_format
                    )
    end
  end
end
