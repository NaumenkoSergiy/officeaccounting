class Koatuu < ActiveRecord::Base
  scope :by_code_and_name, -> (query) {
    where("lower(concat(code, ' ', name)) LIKE ?", "%#{query.downcase}%")
    .limit(10)
    .collect{ |k| { id: k.code_name, text: k.code_name } }
  }

  def code_name
    "#{code} #{name}"
  end
end
