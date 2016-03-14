require 'rails_helper'

RSpec.describe MoneyController, type: :controller do
  let!(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let!(:company) { FactoryGirl.create(:company) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#index' do
    it 'return currencies for current_company' do
      2.times { FactoryGirl.create(:currency) }
      get :index
      expect(assigns(:currencies)).to be
      expect(assigns(:search)).to be
      expect(assigns(:registers)).to be

      expect(response).to be_success
      expect(response).to render_template(:index)
    end
  end
end
