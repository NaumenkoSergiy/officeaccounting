class Department < ActiveRecord::Base
  paginates_per 7

  belongs_to :company
  has_many :employees

  validates :name, presence: true

  def assigned?
    employees.any?
  end
end
