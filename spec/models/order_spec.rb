require 'rails_helper'

RSpec.describe Order, :type => :model do

  describe 'validation rules' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:bank_id) }
    it { should validate_presence_of(:currency) }
    it { should validate_presence_of(:total) }
    it { should validate_presence_of(:total_grn) }
    it { should validate_presence_of(:rate) }
    it { should validate_presence_of(:commission) }
    it { should validate_presence_of(:account_grn_id) }
    it { should validate_presence_of(:type_order) }
    it { should validate_presence_of(:account_rate_id) }
    it { should_not allow_value('').for(:bank_id) }
    it { should_not allow_value('').for(:currency) }
    it { should_not allow_value('').for(:total) }
    it { should_not allow_value('').for(:total_grn) }
    it { should_not allow_value('').for(:rate) }
    it { should_not allow_value('').for(:commission) }
    it { should_not allow_value('').for(:account_grn_id) }
    it { should_not allow_value('').for(:type_order) }
    it { should_not allow_value('').for(:account_rate_id) }

    it { should belong_to(:company) }
    it { should belong_to(:bank) }
    it { should belong_to(:grn_account).class_name('Account').with_foreign_key('account_grn_id') }
    it { should belong_to(:foreign_currency_account).class_name('Account').with_foreign_key('account_rate_id') }

    it { should delegate_method(:name).to(:bank).with_prefix(true) }
    it { should delegate_method(:name).to(:grn_account).with_prefix(true) }
    it { should delegate_method(:name).to(:foreign_currency_account).with_prefix(true) }
  end
end
