require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'associations' do
    it { should belong_to(:guide_unit) }
    it { should belong_to(:counterparty) }
    it { should belong_to(:department) }
    it { should belong_to(:company) }
  end

  context 'validations' do
    it { should validate_presence_of(:document_type) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:counterparty) }
    it { should validate_presence_of(:document_number) }
    it { should validate_presence_of(:currency) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:guide_unit) }
    it { should validate_presence_of(:department) }

    it { should_not allow_value('').for(:document_type) }
    it { should_not allow_value('').for(:date) }
    it { should_not allow_value(nil).for(:counterparty) }
    it { should_not allow_value('').for(:document_number) }
    it { should_not allow_value('').for(:currency) }
    it { should_not allow_value('').for(:number) }
    it { should_not allow_value('').for(:title) }
    it { should_not allow_value('').for(:amount) }
    it { should_not allow_value('').for(:price) }
    it { should_not allow_value(nil).for(:guide_unit) }
    it { should_not allow_value(nil).for(:department) }
  end

  context 'delegates' do
    it { should delegate_method(:name).to(:counterparty).with_prefix(true) }
    it { should delegate_method(:name).to(:guide_unit).with_prefix(true) }
  end
end
