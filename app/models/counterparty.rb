class Counterparty < ActiveRecord::Base
  belongs_to :company
  belongs_to :bank

  validates :name, :title, :adress, presence: true
  validates_numericality_of :edrpo, :mfo, :account
end
