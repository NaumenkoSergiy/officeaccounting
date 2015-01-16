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
  has_many :currencies
  has_many :accounts

  after_create { set_registration }

  scope :non_current_user, -> (id) {
    company_ids = UserCompany.user_companies(id).pluck(:company_id)
    where("id not in (?)", company_ids.compact)
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

  def full_short_name
    "#{full_name} (#{short_name})"
  end

  def current_company user_id
    user_companies.where(user_id: user_id, company_id: id)
                  .first
                  .current_company
  end
end
