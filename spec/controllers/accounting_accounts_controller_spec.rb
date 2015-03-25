require 'rails_helper'

RSpec.describe AccountingAccountsController, type: :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company) { FactoryGirl.create(:company) }
  let(:accounting_account_attributes) { FactoryGirl.attributes_for(:accounting_account) }
  let(:unvalid_accounting_account_attributes) { FactoryGirl.attributes_for(:accounting_account,
                                                                           name:'',
                                                                           ap:'',
                                                                           invoice_type: '',
                                                                           account_number: '',
                                                                           subcount1: '',
                                                                           subcount2: '',
                                                                           subcount3: '')}
  let!(:accounting_account) { FactoryGirl.create(:accounting_account) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do
    it { expect { post :create, accounting_account: accounting_account_attributes, format: :js }.to change(AccountingAccount, :count).by(1) }
    it 'not add accounting_account for none current user', :skip_before do
      expect {
        post :create, { accounting_account: accounting_account_attributes, format: :js }
      }.to_not change(AccountingAccount, :count)
    end
    it { expect { post :create, accounting_account: unvalid_accounting_account_attributes, format: :js }.to_not change(AccountingAccount, :count) }
    it { expect { post :create, accounting_account: unvalid_accounting_account_attributes, format: :js }.to_not change(AccountingAccount, :count) }
  end

  describe '#update' do
    before do
      put :update, { id: accounting_account.id, accounting_account: accounting_account_attributes, format: :json }
      accounting_account.reload
    end

    it { expect(accounting_account.name).to eql(accounting_account_attributes[:name]) }
    it { expect(accounting_account.ap).to eql(accounting_account_attributes[:ap]) }
    it { expect(accounting_account.invoice_type).to eql(accounting_account_attributes[:invoice_type].to_s) }
    it { expect(accounting_account.subcount1).to eql(accounting_account_attributes[:subcount1]) }
    it { expect(accounting_account.subcount2).to eql(accounting_account_attributes[:subcount2]) }
    it { expect(accounting_account.subcount3).to eql(accounting_account_attributes[:subcount3]) }
  end

  describe '#destroy' do
    it { expect { delete :destroy, id: accounting_account.id, format: :js }.to change(AccountingAccount, :count).by(-1) }
  end
end
