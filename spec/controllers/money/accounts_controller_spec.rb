require 'rails_helper'

RSpec.describe Money::AccountsController, type: :controller do
  let!(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let!(:company) { FactoryGirl.create(:company) }
  let!(:account_attributes) { FactoryGirl.attributes_for(:account) }
  let!(:unvalid_account_attributes) { FactoryGirl.attributes_for(:account, name: '', number: '') }
  let!(:account) { FactoryGirl.create(:account) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do
    it 'add account' do
      expect do
        post :create, { account: account_attributes }.merge!(format: :js)
      end.to change(Account, :count).by(1)
    end

    it 'not add account for none current user', :skip_before do
      expect do
        post :create, { account: account_attributes }.merge!(format: :js)
      end.to_not change(Account, :count)
    end

    it 'add account from unvalid account attributes' do
      expect do
        post :create, { account: unvalid_account_attributes }.merge!(format: :js)
      end.to_not change(Account, :count)
    end

    it 'not add account with empty attributes' do
      expect do
        post :create, { account: unvalid_account_attributes }.merge!(format: :js)
      end.to_not change(Account, :count)
    end
  end

  describe '#update' do
    before do
      put :update, { id: account.id, account: account_attributes }.merge!(format: :json)
      account.reload
    end
    it { expect(account.name).to eql(account_attributes[:name]) }
    it { expect(account.account_type).to eql(account_attributes[:account_type].to_s) }
    it { expect(account.number).to eql(account_attributes[:number].to_i) }
    it { expect(account.currency).to eql(account_attributes[:currency].to_s) }
    it { expect(account.bank_id).to eql(account_attributes[:bank_id].to_i) }
  end

  describe '#destroy' do
    it 'destroy account' do
      expect do
        delete :destroy, { id: account.id }.merge!(format: :js)
      end.to change(Account, :count).by(-1)
    end
  end
end
