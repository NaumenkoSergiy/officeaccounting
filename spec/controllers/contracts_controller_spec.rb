require 'rails_helper'

RSpec.describe ContractsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company) { FactoryGirl.create(:company) }
  let(:contract_attributes) { FactoryGirl.attributes_for(:contract) }
  let(:unvalid_contract_attributes) { FactoryGirl.attributes_for(:contract, date:'',
                                                                            number:'',
                                                                            contract_type: '',
                                                                            validity: ''
                                                                            )}
  let(:counterparty) { FactoryGirl.create(:counterparty) }
  let!(:contract) { FactoryGirl.create(:contract, company_id: company.id, counterparty_id: counterparty.id) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do

    it 'add contract' do
      expect {
        post :create, { contract: contract_attributes }.merge!(format: :js)
      }.to change(Contract, :count).by(1)
    end

    it 'not add contract for none current user', :skip_before do
      expect {
        post :create, { contract: contract_attributes }.merge!(format: :js)
      }.to_not change(Contract, :count)
    end

    it 'add contract from unvalid contract attributes' do
      expect {
        post :create, { contract: unvalid_contract_attributes }.merge!(format: :js)
      }.to_not change(Contract, :count)
    end

    it 'not add contract with empty attributes' do
      expect {
        post :create, { contract: unvalid_contract_attributes }.merge!(format: :js)
      }.to_not change(Contract, :count)
    end
  end

  describe '#update' do
    before do
      put :update, { id: contract.id, contract: contract_attributes }.merge!(format: :json)
      contract.reload
    end
    it { expect(contract.date).to eql(contract_attributes[:date]) }
    it { expect(contract.number).to eql(contract_attributes[:number]) }
    it { expect(contract.contract_type).to eql(contract_attributes[:contract_type].to_s) }
    it { expect(contract.validity).to eql(contract_attributes[:validity]) }
  end

  describe '#destroy' do

    it 'destroy contract' do
      expect {
        delete :destroy, { id: contract.id }.merge!(format: :js)
      }.to change(Contract, :count).by(-1)
    end
  end
end
