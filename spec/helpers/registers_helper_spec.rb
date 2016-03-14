require 'rails_helper'

RSpec.describe RegistersHelper, type: :helper do
  describe '#document_type' do
    it 'returns document_type for cost' do
      expect(helper.document_type('costs')).to eq(MoneyRegister::DOCUMENT_TYPE_COST)
    end

    it 'returns document_type for income' do
      expect(helper.document_type).to eq(MoneyRegister::DOCUMENT_TYPE_INCOME)
    end
  end
end
