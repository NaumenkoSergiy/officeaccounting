class SettingsController < ApplicationController
  before_filter :redirect_to_new_session

  def index
    redirect_to new_session_path unless current_user
  end

  def show
    @company    = current_user.companies.find(params[:id])
    @bookkeeper = @company.officials.find_by(official_type: 'Головний бухгалтер')
    @director   = @company.officials.find_by(official_type: 'Директор')
    @incorporation_forms = get_incorporation_forms
  end

  def get_incorporation_forms
    IncorporationForm.all
                        .sort_by{|f| f.name}
                        .collect do |f|
                        {value: "#{f.number} #{f.name}", 
                        text:  "#{f.number} #{f.name}"}
                        end
  end
end
