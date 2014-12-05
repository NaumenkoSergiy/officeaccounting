class SettingsController < ApplicationController
  before_filter :has_company?, only: [:index]

  def index
    redirect_to new_session_path unless current_user
  end
end
