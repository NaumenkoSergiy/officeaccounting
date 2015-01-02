class Koatuu < ActiveRecord::Base
  def self.get_all
    all.sort_by{|k| k.name}
       .collect{|k| ["#{k.code} #{k.name}", "#{k.code} #{k.name}"] }
  end
end
