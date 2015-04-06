class MainTool < ActiveRecord::Base
  paginates_per 7

  belongs_to :company

  validates :title, :date, presence: true

  TYPES = [:Building, :Vehicle, :Office, :Furniture, :Equipment]

  scope :by_type, -> (type) { where('type = ?', type).order('main_tools.created_at DESC') }
end
