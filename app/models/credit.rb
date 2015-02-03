class Credit < ActiveRecord::Base
  belongs_to :company
  belongs_to :bank

  CREDIT_TYPE = {
    :short_symbol => :short, 
    :long_symbol => :long
  }
end
