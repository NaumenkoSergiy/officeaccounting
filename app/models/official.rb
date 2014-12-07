class Official < ActiveRecord::Base
  validates :official_type, :name, :tin, :phone, :email, presence: true

  belongs_to :company
end
