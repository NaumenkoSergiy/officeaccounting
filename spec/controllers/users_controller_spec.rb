require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  ROLE = ['edit', 'view']

  describe '#create' do
    let!(:user_attributes) { FactoryGirl.attributes_for(:user) }

    it 'create new user' do
      expect { 
        post :create, user_attributes 
      }.to change(User, :count).by(1)
    end
  end

  describe '#create_delegete' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:user_delegate) { FactoryGirl.attributes_for(:user) }
    let!(:company) { FactoryGirl.create(:company) }

    before(:each) do |test|
      session[:user_id] = user.id unless test.metadata[:skip_before]
      FactoryGirl.create(:user_company, company_id: company.id, user_id: user.id)
    end

    it 'create delegete user' do
      role = ROLE[rand(2)]
      expect { 
        post :create_delegate, email: user_delegate[:email],
                               role: role,
                               company_id: company.id
      }.to change(User, :count).by(1)
      expect(User.last.role).to eq(role)
    end

    it 'not create delegete user from none autorizate user', :skip_before do
      role = ROLE[rand(2)]
      expect { 
        post :create_delegate, email: user_delegate[:email],
                               role: role,
                               company_id: company.id
      }.to_not change(User, :count)
      expect(User.last.role).to_not eq(role)
    end

    it 'not valid email' do
      role = ROLE[rand(2)]
      expect { 
        post :create_delegate, email: "viktor.com",
                               role: role,
                               company_id: company.id
      }.to_not change(User, :count)
    end
  end
end
