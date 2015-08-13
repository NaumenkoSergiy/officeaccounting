require 'rails_helper'

RSpec.describe Personnels::DepartmentsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company) { FactoryGirl.create(:company) }
  let(:department_attributes) { FactoryGirl.attributes_for(:department) }
  let(:unvalid_department_attributes) { FactoryGirl.attributes_for(:department, name: '') }
  let!(:department) { FactoryGirl.create(:department, company_id: company.id) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do

    it 'add department' do
      expect {
        post :create, { department: department_attributes }.merge!(format: :js)
      }.to change(Department, :count).by(1)
    end

    it 'not add department for none current user', :skip_before do
      expect {
        post :create, { department: department_attributes }.merge!(format: :js)
      }.to_not change(Department, :count)
    end

    it 'add department from unvalid department attributes' do
      expect {
        post :create, { department: unvalid_department_attributes }.merge!(format: :js)
      }.to_not change(Department, :count)
    end

  end

  describe '#update' do
    before do
      put :update, { id: department.id, department: department_attributes }.merge!(format: :json)
      department.reload
    end
    it { expect(department.name).to eql(department_attributes[:name]) }
  end

  describe '#destroy' do

    it 'destroy department' do
      expect {
        delete :destroy, { id: department.id }.merge!(format: :js)
      }.to change(Department, :count).by(-1)
    end

    context 'no destroy, department in used' do
      let!(:employee) { FactoryGirl.create(:employee, department_id: department.id) }

      it { expect{ delete :destroy, { id: department.id }.merge!(format: :js) }.to change(Department, :count).by(0) }
    end

  end
end
