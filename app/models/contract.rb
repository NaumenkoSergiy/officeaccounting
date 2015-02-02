class Contract < ActiveRecord::Base
  
  CONTRACT_TYPE = {
    'Товар' => :product,
    'Послуга'=> :service
  }
end
