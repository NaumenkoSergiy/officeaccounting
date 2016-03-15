require 'rails_helper'

RSpec.describe CurrencyTransaction, type: :model do
  describe 'association' do
    it { should belong_to(:company) }
    it { should belong_to(:order) }
  end

  describe 'validation rules' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:order_id) }
    it { should validate_presence_of(:total_pf) }
    it { should_not allow_value('').for(:order_id) }
    it { should_not allow_value('').for(:total_pf) }
  end

  describe 'delegation' do
    it { should delegate_method(:currency).to(:order).with_prefix(true) }
    it { should delegate_method(:total).to(:order).with_prefix(true) }
    it { should delegate_method(:rate).to(:order).with_prefix(true) }
    it { should delegate_method(:commission).to(:order).with_prefix(true) }
    it { should delegate_method(:total_grn).to(:order).with_prefix(true) }
    it { should delegate_method(:grn_account_name).to(:order) }
    it { should delegate_method(:foreign_currency_account_name).to(:order) }
  end
end
