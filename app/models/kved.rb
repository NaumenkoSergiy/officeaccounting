class Kved < ActiveRecord::Base
  def section_number_name
    "#{section} #{number} #{name}"
  end
end
