class SettingsController < ApplicationController
  def index
    redirect_to new_session_path unless current_user
  end
end
