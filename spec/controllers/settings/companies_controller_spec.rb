require 'rails_helper'

RSpec.describe Settings::CompaniesController, :type => :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company_attributes) { FactoryGirl.attributes_for(:company) }

  before(:each) do |test|
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do
    let(:unvalid_company_attributes) { FactoryGirl.attributes_for(:unvalid_company) }

    it 'create new company' do
      expect {
        post :create, company_attributes
      }.to change(Company, :count).by(1)
    end

    it 'not create new company with unvalid data' do
      expect {
        post :create, unvalid_company_attributes
      }.to_not change(Company, :count)
    end

    it 'not create new company without current user', :skip_before do
      expect {
        post :create, company_attributes
      }.to_not change(Company, :count)
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
        post :create, company_attributes
        @company = Company.last
      end

      subject { post :add_existing_company, company: @company.id }
      it { expect { subject }.to_not change(UserCompany, :count) }
      it { expect { subject }.to_not change(Company, :count) }
    end
  end

end
