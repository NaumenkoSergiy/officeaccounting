class Department < ActiveRecord::Base
  acts_as_paranoid

  paginates_per 7

  belongs_to :company

  has_many :employees
  has_many :products

  validates :name, presence: true

  def assigned?
    employees.any?
  end
end
