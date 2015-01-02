class TaxInspection < ActiveRecord::Base
  def self.get_all
    all.collect{|t| t.name}
  end
end
