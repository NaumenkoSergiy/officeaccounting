require 'rails_helper'

RSpec.describe DelegatesController, :type => :controller do
  ROLE = ['edit', 'view']

  describe '#create_delegete' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:user_delegate) { FactoryGirl.attributes_for(:user) }
    let!(:company) { FactoryGirl.create(:company) }

    before(:each) do |test|
      session[:user_id] = user.id unless test.metadata[:skip_before]
      FactoryGirl.create(:user_company, company_id: company.id, user_id: user.id)
    end

    it 'create delegete a new user' do
      role = ROLE[rand(2)]
      expect { post :create, email: user_delegate[:email], company_id: company.id, role: role, format: :js }.to change(User, :count).by(1)
      expect(UserCompany.last.role).to eq(role)
    end

    it 'not create delegete user from none autorizate user', :skip_before do
      role = ROLE[rand(2)]
      expect {
        post :create, email: user_delegate[:email],
                      company_id: company.id
      }.to_not change(User, :count)
      expect(UserCompany.last.role).to_not eq(role)
    end

    it 'not valid email' do
      role = ROLE[rand(2)]
      expect {
        post :create, email: "viktor.com",
                      company_id: company.id,
                      format: :js
      }.to_not change(User, :count)
    end
  end
end
