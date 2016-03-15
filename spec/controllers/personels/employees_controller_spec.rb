require 'rails_helper'

RSpec.describe Personnels::EmployeesController, type: :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company) { FactoryGirl.create(:company) }
  let(:employee_attributes) { FactoryGirl.attributes_for(:employee) }
  let(:unvalid_employee_attributes) do
    FactoryGirl.attributes_for(:employee, personnel_number: '',
                                          type: '',
                                          name: '',
                                          passport: '',
                                          adress: '',
                                          date_birth: '',
                                          ipn: '',
                                          department_id: '',
                                          position_id: ''
                              )
  end
  let!(:employee) { FactoryGirl.create(:employee, company_id: company.id) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do
    it 'add employee' do
      expect do
        post :create, { employee: employee_attributes }.merge!(format: :js)
      end.to change(Employee, :count).by(1)
    end

    it 'not add employee for none current user', :skip_before do
      expect do
        post :create, { employee: employee_attributes }.merge!(format: :js)
      end.to_not change(Employee, :count)
    end

    it 'add employee from unvalid employee attributes' do
      expect do
        post :create, { employee: unvalid_employee_attributes }.merge!(format: :js)
      end.to_not change(Employee, :count)
    end
  end

  describe '#update' do
    before do
      put :update, { id: employee.id, employee: employee_attributes }.merge!(format: :json)
      employee.reload
    end
    it { expect(employee.name).to eql(employee_attributes[:name]) }
  end

  describe '#destroy' do
    it 'destroy employee' do
      expect do
        delete :destroy, { id: employee.id }.merge!(format: :js)
      end.to change(Employee, :count).by(-1)
    end
  end
end
