require 'rails_helper'

RSpec.describe AccountingAccount, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:account_number) }
  it { should_not allow_value('').for(:name) }
  it { should_not allow_value('').for(:account_number) }
end
