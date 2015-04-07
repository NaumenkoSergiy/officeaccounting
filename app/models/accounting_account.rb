class AccountingAccount < ActiveRecord::Base
  acts_as_paranoid

  has_many :nomenclatures

  paginates_per 5
  extend ActsAsTree::TreeView
  acts_as_tree order: 'account_number'

  validates :name, :account_number, presence: true
  validates :account_number, uniqueness: true

  GROUPS = [:assets, :capital, :obligations, :income_a, :costs_a]

  def update_directory_field(value)
    parent.update_attributes(directory: value)
  end

  def children_size
    parent.children.size
  end

  def account_parent?
    parent.present?
  end
end
