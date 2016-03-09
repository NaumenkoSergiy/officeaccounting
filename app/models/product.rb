class Product < ActiveRecord::Base
  belongs_to :guide_unit, -> { with_deleted }
  belongs_to :counterparty, -> { with_deleted }
  belongs_to :department, -> { with_deleted }
  belongs_to :company

  validates  :document_type, :date, :counterparty, :document_number, :document_date,
             :currency, :number, :title, :amount, :price, :guide_unit, :department, presence: true

  validates_uniqueness_of :number, scope: :company_id

  delegate :name, to: :counterparty, prefix: true
  delegate :name, to: :guide_unit, prefix: true

  DOCUMENT_TYPE = [:profit_invoice, :certificate_of_completion, :receiving_products_under_implementation]
end
