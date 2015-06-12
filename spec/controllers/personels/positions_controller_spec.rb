require 'rails_helper'

RSpec.describe Personnels::PositionsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company) { FactoryGirl.create(:company) }
  let(:position_attributes) { FactoryGirl.attributes_for(:position) }
  let(:unvalid_position_attributes) { FactoryGirl.attributes_for(:position, title: '') }
  let!(:position) { FactoryGirl.create(:position, company_id: company.id) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do

    it 'add position' do
      expect {
        post :create, { position: position_attributes }.merge!(format: :js)
      }.to change(Position, :count).by(1)
    end

    it 'not add position for none current user', :skip_before do
      expect {
        post :create, { position: position_attributes }.merge!(format: :js)
      }.to_not change(Position, :count)
    end

    it 'add position from unvalid position attributes' do
      expect {
        post :create, { position: unvalid_position_attributes }.merge!(format: :js)
      }.to_not change(Position, :count)
    end

  end

  describe '#update' do
    before do
      put :update, { id: position.id, position: position_attributes }.merge!(format: :json)
      position.reload
    end
    it { expect(position.title).to eql(position_attributes[:title]) }
  end

  describe '#destroy' do

    it 'destroy position' do
      expect {
        delete :destroy, { id: position.id }.merge!(format: :js)
      }.to change(Position, :count).by(-1)
    end

    context 'no destroy, position in used' do
      let!(:employee) { FactoryGirl.create(:employee, position_id: position.id) }

      it { expect{ delete :destroy, { id: position.id }.merge!(format: :js) }.to change(Position, :count).by(0) }
    end

  end
end
