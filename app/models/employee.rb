class Employee < ActiveRecord::Base
  acts_as_paranoid
  paginates_per 7

  belongs_to :company
  belongs_to :department
  belongs_to :position

  TYPES = [:Basic_place, :Part]

  delegate :name, to: :department, prefix: true
  delegate :title, to: :position, prefix: true

  validates :name, :personnel_number, :type, :date_birth, :passport, :ipn, :adress, :department_id, :position_id, presence: true
end
