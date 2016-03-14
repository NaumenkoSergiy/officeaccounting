require 'rails_helper'

RSpec.describe Nomenclature, type: :model do
  context 'associations' do
    it { should belong_to(:company) }
    it { should belong_to(:guide_unit) }
    it { should belong_to(:accounting_account) }
  end

  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:accounting_account_id) }
    it { should validate_presence_of(:guide_unit_id) }
    it { should validate_presence_of(:count) }
    it { should_not allow_value('').for(:title) }
    it { should_not allow_value('').for(:type) }
    it { should_not allow_value('').for(:accounting_account_id) }
    it { should_not allow_value('').for(:guide_unit_id) }
    it { should_not allow_value('').for(:count) }
  end
end
