class IncorporationForm < ActiveRecord::Base

  def number_name
    "#{number} #{name}"
  end
end
