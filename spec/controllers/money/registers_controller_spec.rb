require 'rails_helper'

RSpec.describe Money::RegistersController, type: :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company) { FactoryGirl.create(:company) }
  let(:money_register_attributes) { FactoryGirl.attributes_for(:money_register) }
  let(:unvalid_money_register_attributes) { FactoryGirl.attributes_for(:money_register, type_document: '', total: '') }
  let!(:money_register) { FactoryGirl.create(:money_register) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do
    it 'add money_register' do
      expect do
        post :create, { money_register: money_register_attributes }.merge!(format: :js)
      end.to change(MoneyRegister, :count).by(1)
    end

    it 'not add money_register for none current user', :skip_before do
      expect do
        post :create, { money_register: money_register_attributes }.merge!(format: :js)
      end.to_not change(MoneyRegister, :count)
    end

    it 'add money_register from unvalid money_register attributes' do
      expect do
        post :create, { money_register: unvalid_money_register_attributes }.merge!(format: :js)
      end.to_not change(MoneyRegister, :count)
    end

    it 'not add money_register with empty attributes' do
      expect do
        post :create, { money_register: unvalid_money_register_attributes }.merge!(format: :js)
      end.to_not change(MoneyRegister, :count)
    end
  end

  describe '#destroy' do
    it 'destroy money_register' do
      expect do
        delete :destroy, { id: money_register.id }.merge!(format: :js)
      end.to change(MoneyRegister, :count).by(-1)
    end
  end
end
