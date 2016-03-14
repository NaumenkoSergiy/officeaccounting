require 'rails_helper'

RSpec.describe Money::CreditsController, type: :controller do
  let!(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let!(:company) { FactoryGirl.create(:company) }
  let!(:bank) { FactoryGirl.create(:bank) }
  let!(:credit) { FactoryGirl.create(:credit, company_id: company.id, bank_id: bank.id) }
  let!(:credit_attributes) { FactoryGirl.attributes_for(:credit) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do
    it 'add create' do
      expect do
        post :create, { credit: credit_attributes }.merge!(format: :js)
      end.to change(Credit, :count).by(1)
    end

    it 'not add credit for none current user', :skip_before do
      expect do
        post :create, { credit: credit_attributes }.merge!(format: :js)
      end.to_not change(Credit, :count)
    end
  end

  describe '#update' do
    before do
      put :update, { id: credit.id, credit: credit_attributes }.merge!(format: :json)
      credit.reload
    end
    it { expect(credit.name).to eql(credit_attributes[:name]) }
    it { expect(credit.credit_type.to_sym).to eql(credit_attributes[:credit_type]) }
    it { expect(credit.account_number).to eql(credit_attributes[:account_number]) }
  end

  describe '#destroy' do
    it 'destroy credit' do
      expect do
        delete :destroy, id: credit.id, format: :js
      end.to change(Credit, :count).by(-1)
    end
  end
end
