class RegistrationPresenter < BasePresenter
  presents :registration

  def kveds
    Kved.select(:section, :number, :name).map(&:section_number_name).to_s.html_safe
  end
end
