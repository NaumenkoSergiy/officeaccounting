class Company < ActiveRecord::Base
  validates :full_name,
            :short_name,
            :latin_name,
            :juridical_address,
            :numbering_format,
            presence: true

  belongs_to :user

  has_one :registration
  has_many :officials
  has_one :bank_account
end
