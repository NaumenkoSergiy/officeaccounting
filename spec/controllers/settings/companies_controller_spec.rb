require 'rails_helper'

RSpec.describe Settings::CompaniesController, type: :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company_attributes) { FactoryGirl.attributes_for(:company) }

  before(:each) do |test|
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#new' do
    it 'initialize new company' do
      get :new, format: :js
      expect(assigns(:company)).to be_a_new(Company)
    end
  end

  describe '#create' do
    let(:unvalid_company_attributes) { FactoryGirl.attributes_for(:unvalid_company) }

    it 'create new company' do
      expect do
        post :create, { company: company_attributes }.merge!(format: :js)
      end.to change(Company, :count).by(1)
    end

    it 'not create new company with unvalid data' do
      expect do
        post :create, { company: unvalid_company_attributes }.merge!(format: :js)
      end.to_not change(Company, :count)
    end

    it 'not create new company without current user', :skip_before do
      expect do
        post :create, company_attributes
      end.to_not change(Company, :count)
    end
  end

  describe '#add_existing_company' do
    let!(:company) { FactoryGirl.create(:company) }
    let!(:user1) { FactoryGirl.create(:user, activate_token: nil) }

    before(:each) do |test|
      session[:user_id] = user1.id unless test.metadata[:skip_before]
    end

    context 'add existing company' do
      subject { post :add_existing_company, company: company.id }
      it { expect { subject }.to change(UserCompany, :count).by(1) }
      it { expect { subject }.to_not change(Company, :count) }
    end

    context 'not add existing company without current_user', :skip_before do
      subject { post :add_existing_company, company: company.id }
      it { expect { subject }.to_not change(UserCompany, :count) }
      it { expect { subject }.to_not change(Company, :count) }
    end

    context 'not add current_user company for current_user' do
      before do
        post :create, { company: company_attributes }.merge!(format: :js)
        @company = Company.last
      end

      subject { post :add_existing_company, company: @company.id }
      it { expect { subject }.to_not change(UserCompany, :count) }
      it { expect { subject }.to_not change(Company, :count) }
    end
  end

  describe '#change_company' do
    let(:old_current_company) { FactoryGirl.create(:company) }
    let(:new_current_company) { FactoryGirl.create(:company) }

    before do
      FactoryGirl.create(:user_company, company: old_current_company, user: user, current_company: true)
      FactoryGirl.create(:user_company, company: new_current_company, user: user)
      post :change_company, company_id: new_current_company.id
      user.reload
    end

    it { expect(user.current_company).to eql(new_current_company) }
  end
end
