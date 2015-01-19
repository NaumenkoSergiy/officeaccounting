class Cashier < ActiveRecord::Base
  belongs_to :company
  belongs_to :bank

  validates :name, presence: true
end
