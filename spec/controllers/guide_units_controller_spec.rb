require 'rails_helper'

RSpec.describe GuideUnitsController, type: :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company) { FactoryGirl.create(:company) }
  let(:guide_unit_attributes) { FactoryGirl.attributes_for(:guide_unit, user_id: user.id) }
  let(:unvalid_guide_unit_attributes) { FactoryGirl.attributes_for(:guide_unit, name:'', user_id: '')}
  let!(:guide_unit) { FactoryGirl.create(:guide_unit) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do
    it { expect { post :create, guide_unit: guide_unit_attributes, format: :js }.to change(GuideUnit, :count).by(1) }
    it 'not add guide_unit for none current user', :skip_before do
      expect {
        post :create, { guide_unit: guide_unit_attributes, format: :js }
      }.to_not change(GuideUnit, :count)
    end
    it { expect { post :create, guide_unit: unvalid_guide_unit_attributes, format: :js }.to_not change(GuideUnit, :count) }
  end

  describe '#update' do
    before do
      put :update, { id: guide_unit.id, guide_unit: guide_unit_attributes, format: :json }
      guide_unit.reload
    end

    it { expect(guide_unit.name).to eql(guide_unit_attributes[:name]) }
  end

  describe '#destroy' do
    it { expect { delete :destroy, id: guide_unit.id, format: :js }.to change(GuideUnit, :count).by(-1) }
  end
end
