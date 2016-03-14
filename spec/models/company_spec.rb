require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should have_one(:bank_account) }
  it { should have_one(:bank).through(:bank_account) }
  it { should have_many(:user_companies) }
  it { should have_many(:users).through(:user_companies) }
  it { should have_one(:registration) }
  it { should have_many(:officials) }
  it { should have_many(:currencies) }
  it { should have_many(:credits) }
  it { should have_many(:accounts) }
  it { should have_many(:cashiers) }
  it { should have_many(:counterparties) }
  it { should have_many(:contracts) }
  it { should have_many(:money_registers) }
  it { should delegate_method(:name).to(:bank).with_prefix(true) }
  it { should delegate_method(:account).to(:bank_account).with_prefix(true) }
  it { should delegate_method(:mfo).to(:bank_account).with_prefix(true) }
end
