class Kved < ActiveRecord::Base
  def self.get_all
    all.map{|k| "#{k.section} #{k.number} #{k.name}"}.to_s.html_safe
  end
end
