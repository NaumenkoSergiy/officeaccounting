class RegistrationPresenter < BasePresenter
  presents :registration

  def kveds
    Kved.all.map{|k| k.section_number_name}.to_s.html_safe
  end
end