class GuideUnit < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  has_many :nomenclatures
  has_many :products

  validates :name, presence: true
end
