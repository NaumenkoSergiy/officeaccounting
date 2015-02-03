class Contract < ActiveRecord::Base
  belongs_to :company
  belongs_to :counterparty

  validates :date, :validity, :number, presence: true
  
  CONTRACT_TYPE = {
    'Товар' => :product,
    'Послуга'=> :service
  }
end
