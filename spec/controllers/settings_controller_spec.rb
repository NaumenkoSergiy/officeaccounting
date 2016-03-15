require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company_complete) { FactoryGirl.create(:company, state: :complite) }
  let(:company_uncomplete) { FactoryGirl.create(:company, state: :step2) }

  before(:each) do |test|
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#show' do
    it 'not redirect to new company path because company complete' do
      FactoryGirl.create(:user_company, company: company_complete, user: user, current_company: true)
      get :show, id: company_complete.id
      expect(response).to_not redirect_to(new_settings_company_path)
    end

    it 'redirect to new company path because company is not complete' do
      FactoryGirl.create(:user_company, company: company_uncomplete, user: user, current_company: true)
      get :show, id: company_uncomplete.id
      expect(response).to redirect_to(new_settings_company_path)
    end
  end
end
