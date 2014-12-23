class Register < ActiveRecord::Base
  belongs_to :counterparty
  belongs_to :user
end
