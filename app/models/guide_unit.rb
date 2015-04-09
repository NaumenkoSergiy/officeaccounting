class GuideUnit < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  has_many :nomenclatures

  validates :name, presence: true
end
