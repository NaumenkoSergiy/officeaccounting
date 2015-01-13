require 'rails_helper'

RSpec.describe MoneyController, :type => :controller do
  let!(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let!(:company) { FactoryGirl.create(:company) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#index' do
    it 'return currencies for current_company' do
      2.times{ FactoryGirl.create(:currency) }
      get :index
      expect(response).to be_success
      expect(assigns(:currencies)).to be
    end
  end
end
