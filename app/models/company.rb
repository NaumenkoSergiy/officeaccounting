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

  after_save { set_registration }

  scope :non_current_user, -> {
    where(active: true)
  }

  state_machine :state, initial: :step1 do
    event :set_registration do
      transition :step1 => :step2
    end

    event :set_official do
      transition :step2 => :step3
    end

    event :set_bank_account do
      transition :step3_1 => :step4
      transition :step3   => :step3_1
    end

    event :complite do
      transition :step3_1 => :complite
      transition :step4   => :complite
    end
  end
end
