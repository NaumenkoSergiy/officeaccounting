class Contract < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :company
  belongs_to :counterparty
  belongs_to :counterparty_including_deleted, class_name: 'Counterparty', foreign_key: 'counterparty_id', with_deleted: true
  has_many :money_registers

  validates :date, :counterparty_id, :validity, :number, presence: true

  scope :contracts_for_conterparty, -> (id) {
    where(counterparty_id: id).pluck(:id, :number)
                              .collect do |key, value|
                                { value: "#{key}", text:  "#{value}" }
                              end
  }

  CONTRACT_TYPE = [:product, :service]
end
