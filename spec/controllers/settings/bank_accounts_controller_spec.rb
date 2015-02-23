require 'rails_helper'

RSpec.describe Settings::BankAccountsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company) { FactoryGirl.create(:company) }
  let(:bank_account_attributes) { FactoryGirl.attributes_for(:bank_account) }
  let(:unvalid_bank_account_attributes) do
    FactoryGirl.attributes_for(:unvalid_bank_account)
  end

  before(:each) do
    session[:user_id] = user.id
    FactoryGirl.create(:user_company, user_id: user.id, company_id: company.id)
    FactoryGirl.create(:official, company_id: company.id)
  end

  describe '#create' do
    it 'create new bank_account for company' do
      expect {
        post :create, { bank_account: bank_account_attributes }.merge!(format: :js)
      }.to change(BankAccount, :count).by(1)
    end

    it 'not create new bank account for company with unvalid datas' do
      expect {
        post :create, { bank_account: unvalid_bank_account_attributes }.merge!(format: :js)
      }.to_not change(BankAccount, :count)
    end

    context 'create bank account without current_user' do
      before { session[:user_id] = nil }

      it 'not create new bank account for company without current_user' do
        expect {
          post :create, { bank_account: bank_account_attributes }.merge!(format: :js)
        }.to_not change(BankAccount, :count)
      end
    end
  end
end
