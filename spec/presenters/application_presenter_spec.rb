require 'rails_helper'
describe ApplicationPresenter do
  let(:company) { FactoryGirl.create(:company) }
  let(:currency) { FactoryGirl.create(:currency, company_id: company.id) }

  before(:each) do
    @presenter = ApplicationPresenter.new
  end

  describe 'current_company_currency_select' do
    it 'return empty array' do
      @currencies = Currency::AVAILABLE_CURRENCIES.map { |name| FactoryGirl.create(
      :currency, company_id: company.id, name: name) }

      expect(@presenter.current_company_currency_select(@currencies)).to be_empty
    end

    context 'without some currencies' do
      let(:first_curr) { Currency::AVAILABLE_CURRENCIES.first }
      let(:last_curr) { Currency::AVAILABLE_CURRENCIES.last }
      let(:currency1) { FactoryGirl.create(:currency, company_id: company.id,
                                            name: first_curr) }
      let(:currency2) { FactoryGirl.create(:currency, company_id: company.id,
                                            name: last_curr) }
      let(:currencies) { [currency1, currency2] }

      subject {
        @presenter.current_company_currency_select(currencies).map { |e| e[1] }
      }

      it { should_not include(first_curr) }
      it { should_not include(last_curr) }
      it { subject.size.should eq(Currency::AVAILABLE_CURRENCIES.length - 2) }
    end
  end
end
