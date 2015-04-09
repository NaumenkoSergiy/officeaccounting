class Department < ActiveRecord::Base
  paginates_per 7

  belongs_to :company

  validates :name, presence: true
end
