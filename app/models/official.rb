class Official < ActiveRecord::Base
  validates :type, :name, :tin, :phone, :email, presence: true

  belongs_to :company
end
