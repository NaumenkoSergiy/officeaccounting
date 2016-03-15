require 'rails_helper'

RSpec.describe Settings::OfficialsController, type: :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company) { FactoryGirl.create(:company) }
  let(:official_attributes) { FactoryGirl.attributes_for(:official) }
  let(:unvalid_official_attributes) do
    FactoryGirl.attributes_for(:unvalid_official)
  end

  before(:each) do
    session[:user_id] = user.id
    FactoryGirl.create(:user_company, user_id: user.id, company_id: company.id)
  end

  describe '#create' do
    it 'create new officials for company' do
      expect do
        post :create, { official: official_attributes }.merge!(format: :js)
      end.to change(Official, :count).by(1)
    end

    it 'not create new official for company with unvalid datas' do
      expect do
        post :create, { official: unvalid_official_attributes }.merge!(format: :js)
      end.to_not change(Official, :count)
    end

    context 'create official without current_user' do
      before { session[:user_id] = nil }

      it 'not create new official for company without current_user' do
        expect do
          post :create, official_attributes
        end.to_not change(Official, :count)
      end
    end
  end
end
