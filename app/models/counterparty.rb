class Counterparty < ActiveRecord::Base
  belongs_to :company
  belongs_to :bank
  has_many :contracts, :dependent => :destroy

  validates :name, :title, :adress, presence: true
  validates_numericality_of :edrpo, :mfo, :account
end
