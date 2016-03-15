require 'rails_helper'

RSpec.describe Settings::RegistrationsController, type: :controller do
  let(:company) { FactoryGirl.create(:company) }
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:registration_attributes) { FactoryGirl.attributes_for(:registration) }
  let(:unvalid_registration_attributes) do
    FactoryGirl.attributes_for(:unvalid_registration)
  end

  before(:each) do
    session[:user_id] = user.id
    FactoryGirl.create(:user_company, user_id: user.id, company_id: company.id)
  end

  describe '#create' do
    it 'create new registration for company' do
      expect do
        post :create, { registration: registration_attributes }.merge!(format: :js)
      end.to change(Registration, :count).by(1)
    end

    it 'not create new registration for company with unvalid datas' do
      expect do
        post :create, { registration: unvalid_registration_attributes }.merge!(format: :js)
      end.to_not change(Registration, :count)
    end

    context 'create registration without current_user' do
      before { session[:user_id] = nil }

      it 'not create new registration for company without current_user' do
        expect do
          post :create, registration_attributes
        end.to_not change(Registration, :count)
      end
    end
  end
end
