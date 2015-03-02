require 'rails_helper'

RSpec.describe UserCompany, :type => :model do
  context ".user_permission" do
    let(:company) { FactoryGirl.create(:company) }
    let(:user) { FactoryGirl.create(:user) }
    let(:user_to_delegate) { FactoryGirl.create(:user) }

    describe "should return nil" do
      let!(:user_company_1) { FactoryGirl.create(:user_company, company: company, user: user, current_company: true) }
      subject { UserCompany.user_permission(company.id, user_to_delegate.id) }
      it { should be nil }
    end

    describe "should not be nil" do
      let!(:user_company_2) { FactoryGirl.create(:user_company, company: company, user: user_to_delegate,
                                                current_company: true) }
      subject { UserCompany.user_permission(company.id, user_to_delegate.id) }
      it { should_not be nil }
    end
  end
end
