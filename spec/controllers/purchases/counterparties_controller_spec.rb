require 'rails_helper'

RSpec.describe Purchases::CounterpartiesController, type: :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company) { FactoryGirl.create(:company) }
  let(:counterparty_attributes) { FactoryGirl.attributes_for(:counterparty) }
  let(:unvalid_counterparty_attributes) do
    FactoryGirl.attributes_for(:counterparty, title: '',
                                              name: '',
                                              adress: '',
                                              edrpo: '',
                                              mfo: '',
                                              account: ''
                              )
  end
  let!(:counterparty) { FactoryGirl.create(:counterparty) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do
    it 'add counterparty' do
      expect do
        post :create, { counterparty: counterparty_attributes }.merge!(format: :js)
      end.to change(Counterparty, :count).by(1)
    end

    it 'not add counterparty for none current user', :skip_before do
      expect do
        post :create, { counterparty: counterparty_attributes }.merge!(format: :js)
      end.to_not change(Counterparty, :count)
    end

    it 'add counterparty from unvalid counterparty attributes' do
      expect do
        post :create, { counterparty: unvalid_counterparty_attributes }.merge!(format: :js)
      end.to_not change(Counterparty, :count)
    end

    it 'not add counterparty with empty attributes' do
      expect do
        post :create, { counterparty: unvalid_counterparty_attributes }.merge!(format: :js)
      end.to_not change(Counterparty, :count)
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
      expect do
        delete :destroy, { id: counterparty.id }.merge!(format: :js)
      end.to change(Counterparty, :count).by(-1)
    end
  end
end
