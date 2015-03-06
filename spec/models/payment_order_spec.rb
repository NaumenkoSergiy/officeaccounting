require 'rails_helper'

RSpec.describe PaymentOrder, :type => :model do
  it { should belong_to(:account) }
  it { should belong_to(:counterparty) }
  it { should belong_to(:company) }
  it { should belong_to(:article) }

  it { should delegate_method(:name).to(:article).with_prefix(true) }
  it { should delegate_method(:name).to(:counterparty_including_deleted).with_prefix(true) }
  it { should delegate_method(:name).to(:account_including_deleted).with_prefix(true) }
end
