require 'rails_helper'

RSpec.describe Money::CurrencyTransactions::OrdersController, type: :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company) { FactoryGirl.create(:company) }
  let(:order_attributes) { FactoryGirl.attributes_for(:order) }
  let(:unvalid_order_attributes) do
    FactoryGirl.attributes_for(:order, date: '',
                                       bank_id: '',
                                       currency: '',
                                       total: '',
                                       total_grn: '',
                                       rate: '',
                                       commission: '',
                                       account_grn_id: '',
                                       type_order: '',
                                       account_rate_id: '')
  end
  let!(:order) { FactoryGirl.create(:order) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#index' do
    let(:bank) { FactoryGirl.create(:bank) }
    let(:account) { FactoryGirl.create(:account) }
    let(:forreign_account) { FactoryGirl.create(:account) }
    let!(:order) do
      FactoryGirl.create(:order,
                         company: company,
                         bank: bank, grn_account: account,
                         foreign_currency_account: forreign_account)
    end

    it 'has orders' do
      get :index, { format: :json, type: order.type_order }, user_id: user.id
      data = JSON.parse(response.body).first
      expect(data['id']).to eq(order.id)
    end
  end

  describe '#create' do
    it 'add order' do
      expect do
        post :create, { order: order_attributes }.merge!(format: :js)
      end.to change(Order, :count).by(1)
    end

    it 'not add order for none current user', :skip_before do
      expect do
        post :create, { order: order_attributes }.merge!(format: :js)
      end.to_not change(Order, :count)
    end

    it 'add order from unvalid order attributes' do
      expect do
        post :create, { order: unvalid_order_attributes }.merge!(format: :js)
      end.to_not change(Order, :count)
    end

    it 'not add order with empty attributes' do
      expect do
        post :create, { order: unvalid_order_attributes }.merge!(format: :js)
      end.to_not change(Order, :count)
    end
  end

  describe '#destroy' do
    it 'destroy order' do
      expect do
        delete :destroy, { id: order.id }.merge!(format: :js)
      end.to change(Order, :count).by(-1)
    end
  end
end
