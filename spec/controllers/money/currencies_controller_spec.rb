require 'rails_helper'

RSpec.describe Money::CurrenciesController, type: :controller do
  let!(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let!(:company) { FactoryGirl.create(:company) }
  let!(:currency_attributes) { FactoryGirl.attributes_for(:currency) }
  let!(:currency) { FactoryGirl.create(:currency) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do
    it 'add currency to current company' do
      expect do
        post :create, { currency: currency_attributes }.merge!(format: :js)
      end.to change(Currency, :count).by(1)
    end

    it 'not add currencies with same names to same company' do
      expect do
        2.times { post :create, { currency: currency_attributes }.merge!(format: :js) }
      end.to change(Currency, :count).by(1)
    end

    it 'not add currency with empty name' do
      expect do
        post :create, { currency: { name: '' } }.merge!(format: :js)
      end.to_not change(Currency, :count)
    end

    it 'not add currency for none current user', :skip_before do
      expect do
        post :create, { currency: { name: '' } }.merge!(format: :js)
      end.to_not change(Currency, :count)
    end
  end

  describe '#destroy' do
    it 'destroy currency' do
      expect do
        delete :destroy, id: currency.id
      end.to change(Currency, :count).by(-1)
    end
  end
end
