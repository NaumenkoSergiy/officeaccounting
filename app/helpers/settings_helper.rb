module SettingsHelper
  def forms_of_incorporation
    Constants::FORMS_OF_INCORPORATION.sort_by { |type| type[5..-1] }
  end
end
