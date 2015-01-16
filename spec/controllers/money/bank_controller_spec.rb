require 'rails_helper'

RSpec.describe Money::BankController, :type => :controller do
  let!(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let!(:bank_attributes) { FactoryGirl.attributes_for(:bank) }
  let!(:unvalid_bank_attributes) { FactoryGirl.attributes_for(:bank, name: '', code_edrpo: '', mfo: '', lawyer_adress: '')}
  let!(:bank) { FactoryGirl.create(:bank) }

  before(:each) do |test|
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do

    it 'add bank' do
      expect {
        post :create, { bank: bank_attributes }.merge!(format: :js)
      }.to change(Bank, :count).by(1)
    end

    it 'not add currency for none current user', :skip_before do
      expect {
        post :create, { bank: bank_attributes }.merge!(format: :js)
      }.to_not change(Bank, :count)
    end

    it 'add bank from unvalid bank attributes' do
      expect {
        post :create, { bank: unvalid_bank_attributes }.merge!(format: :js)
      }.to_not change(Bank, :count)
    end

    it 'not add bank with empty attributes' do
      expect {
        post :create, { bank: unvalid_bank_attributes }.merge!(format: :js)
      }.to_not change(Bank, :count)
    end
  end

  describe '#update' do
    before do
      put :update, { id: bank.id, bank: bank_attributes }.merge!(format: :json)
      bank.reload
    end
    it { expect(bank.name).to eql(bank_attributes[:name]) }
    it { expect(bank.lawyer_adress).to eql(bank_attributes[:lawyer_adress]) }
    it { expect(bank.code_edrpo).to eql(bank_attributes[:code_edrpo].to_i) }
    it { expect(bank.mfo).to eql(bank_attributes[:mfo].to_i) }
  end

  describe '#destroy' do

    it 'destroy bank' do
      expect {
        delete :destroy, id: bank.id
      }.to change(Bank, :count).by(-1)
    end
  end
end
