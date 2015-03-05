require 'rails_helper'

RSpec.describe PaymentOrder, :type => :model do
  it { should belong_to(:invoice_form) }
  it { should belong_to(:account) }
  it { should belong_to(:counterparty) }
  it { should belong_to(:company) }
  it { should belong_to(:article) }

  it { should delegate_method(:name).to(:article).with_prefix(true) }
  it { should delegate_method(:name).to(:counterparty).with_prefix(true) }
  it { should delegate_method(:name).to(:account).with_prefix(true) }
  it { should delegate_method(:account_number).to(:invoice_form).with_prefix(true) }
end
