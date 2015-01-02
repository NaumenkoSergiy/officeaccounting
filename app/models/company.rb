class Company < ActiveRecord::Base
  validates :full_name,
            :short_name,
            :latin_name,
            :juridical_address,
            :numbering_format,
            presence: true

  has_many :user_companies
  has_many :users, through: :user_companies
  has_one :registration
  has_many :officials
  has_one :bank_account

  scope :non_current_user, -> {
    where(active: true)
  }

  def complite?
    registration && officials.present? && bank_account
  end
end
