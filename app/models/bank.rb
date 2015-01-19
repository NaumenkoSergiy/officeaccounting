class Bank < ActiveRecord::Base
  has_one :account

  validates :name, :lawyer_adress, presence: true
  validates_numericality_of :code_edrpo, :mfo
end
