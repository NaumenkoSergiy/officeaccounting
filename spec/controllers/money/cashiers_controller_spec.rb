require 'rails_helper'

RSpec.describe Money::CashiersController, type: :controller do
  let!(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let!(:company) { FactoryGirl.create(:company) }
  let!(:cashier_attributes) { FactoryGirl.attributes_for(:cashier) }
  let!(:unvalid_cashier_attributes) { FactoryGirl.attributes_for(:cashier, name: '') }
  let!(:cashier) { FactoryGirl.create(:cashier) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do
    it 'add cashier' do
      expect do
        post :create, { cashier: cashier_attributes }.merge!(format: :js)
      end.to change(Cashier, :count).by(1)
    end

    it 'not add cashier for none current user', :skip_before do
      expect do
        post :create, { cashier: cashier_attributes }.merge!(format: :js)
      end.to_not change(Cashier, :count)
    end

    it 'add cashier from unvalid cashier attributes' do
      expect do
        post :create, { cashier: unvalid_cashier_attributes }.merge!(format: :js)
      end.to_not change(Cashier, :count)
    end

    it 'not add cashier with empty attributes' do
      expect do
        post :create, { cashier: unvalid_cashier_attributes }.merge!(format: :js)
      end.to_not change(Cashier, :count)
    end
  end

  describe '#update' do
    before do
      put :update, { id: cashier.id, cashier: cashier_attributes }.merge!(format: :json)
      cashier.reload
    end
    it { expect(cashier.name).to eql(cashier_attributes[:name]) }
    it { expect(cashier.currency).to eql(cashier_attributes[:currency].to_s) }
  end

  describe '#destroy' do
    it 'destroy cashier' do
      expect do
        delete :destroy, { id: cashier.id }.merge!(format: :js)
      end.to change(Cashier, :count).by(-1)
    end
  end
end
