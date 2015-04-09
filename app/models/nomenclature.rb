class Nomenclature < ActiveRecord::Base
  paginates_per 6

  belongs_to :company
  belongs_to :guide_unit, -> { with_deleted }
  belongs_to :accounting_account, -> { with_deleted }

  validates :title, :type, :accounting_account_id, :guide_unit_id, presence: true

  delegate :name, to: :guide_unit, prefix: true
  delegate :account_number, to: :accounting_account

  scope :by_type, -> (type) { where('type = ?', type).order('nomenclatures.created_at DESC') }
end
