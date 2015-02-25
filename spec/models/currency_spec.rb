require 'rails_helper'

RSpec.describe Currency, :type => :model do
  context 'validation name' do
    let(:company) { FactoryGirl.create(:company) }
    let(:first_curr) { Currency::AVAILABLE_CURRENCIES.first }
    let(:last_curr) { Currency::AVAILABLE_CURRENCIES.last }
    let(:currency) { FactoryGirl.create(:currency, company_id: company, name: first_curr) }
    let(:currency1) { FactoryGirl.create(:currency, company_id: company, name: last_curr) }

    describe 'unvalid name validation' do
      it 'has unvalid name' do
        currency.name = ''
        expect(currency).to be_invalid
      end

      it 'has unvalid name' do
        currency1.name = currency.name
        expect(currency1).to be_invalid
      end

      it 'has unvalid name' do
        currency.name = nil
        expect(currency).to be_invalid
      end
    end

    describe 'valid name validation' do
      it 'has valid name' do
        currency.name = 'USD'
        expect(currency).to be_valid
      end
    end
  end
end
