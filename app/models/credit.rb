class Credit < ActiveRecord::Base
  belongs_to :company
  belongs_to :bank

  CREDIT_TYPE = {
    'короткостроковий' => :short, 
    'довгостроковий' => :long
  }
end
