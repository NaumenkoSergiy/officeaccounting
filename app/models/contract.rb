class Contract < ActiveRecord::Base
  belongs_to :company
  belongs_to :counterparty

  validates :date, :validity, :number, presence: true
  
  CONTRACT_TYPE = {
    :product_s => :product,
    :service_s => :service
  }
end
