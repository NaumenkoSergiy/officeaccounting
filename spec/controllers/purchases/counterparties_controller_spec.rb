require 'rails_helper'

RSpec.describe Purchases::CounterpartiesController, :type => :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company) { FactoryGirl.create(:company) }
  let(:counterparty_attributes) { FactoryGirl.attributes_for(:counterparty) }
  let(:unvalid_counterparty_attributes) { FactoryGirl.attributes_for(:counterparty, name: '', start_date: '' )}
  let!(:counterparty) { FactoryGirl.create(:counterparty) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do

    it 'add counterparty' do
      expect {
        post :create, { counterparty: counterparty_attributes }.merge!(format: :js)
      }.to change(Counterparty, :count).by(1)
    end

    it 'not add counterparty for none current user', :skip_before do
      expect {
        post :create, { counterparty: counterparty_attributes }.merge!(format: :js)
      }.to_not change(Counterparty, :count)
    end

    it 'add counterparty from unvalid counterparty attributes' do
      expect {
        post :create, { counterparty: unvalid_counterparty_attributes }.merge!(format: :js)
      }.to_not change(Counterparty, :count)
    end

    it 'not add counterparty with empty attributes' do
      expect {
        post :create, { counterparty: unvalid_counterparty_attributes }.merge!(format: :js)
      }.to_not change(Counterparty, :count)
    end
  end

  describe '#update' do
    before do
      put :update, { id: counterparty.id, counterparty: counterparty_attributes }.merge!(format: :json)
      counterparty.reload
    end
    it { expect(counterparty.name).to eql(counterparty_attributes[:name]) }
  end

  describe '#destroy' do

    it 'destroy counterparty' do
      expect {
        delete :destroy, { id: counterparty.id }.merge!(format: :js)
      }.to change(Counterparty, :count).by(-1)
    end
  end
end
