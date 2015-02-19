class Article < ActiveRecord::Base
  has_many :money_registers

  validates :name, presence: true
end
