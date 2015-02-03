require 'rails_helper'

RSpec.describe Contract, :type => :model do
  context 'validation name' do
    let(:company) { FactoryGirl.create(:company) }
    let(:counterparty) { FactoryGirl.create(:counterparty) }
    let!(:contract) { FactoryGirl.create(:contract, company_id: company.id, counterparty_id: counterparty.id) }

    describe 'unvalid date validation' do
      it 'has unvalid date' do
        contract.date = ''
        expect(contract).to be_invalid
      end

      it 'has unvalid date' do
        contract.date = nil
        expect(contract).to be_invalid
      end
    end

    describe 'valid date validation' do
      it 'has valid date' do
        contract.date = Faker::Date.between(2.days.ago, Date.today)
        expect(contract).to be_valid
      end
    end

    describe 'unvalid number validation' do
      it 'has unvalid number' do
        contract.number = ''
        expect(contract).to be_invalid
      end

      it 'has unvalid number' do
        contract.number = nil
        expect(contract).to be_invalid
      end
    end

    describe 'valid number validation' do
      it 'has valid number' do
        contract.number = Faker::Number.number(8)
        expect(contract).to be_valid
      end
    end

    describe 'unvalid validity validation' do
      it 'has unvalid validity' do
        contract.validity = ''
        expect(contract).to be_invalid
      end

      it 'has unvalid validity' do
        contract.validity = nil
        expect(contract).to be_invalid
      end
    end

    describe 'valid validity validation' do
      it 'has valid validity' do
        contract.validity = Faker::Date.between(2.days.ago, Date.today)
        expect(contract).to be_valid
      end
    end
  end
end
