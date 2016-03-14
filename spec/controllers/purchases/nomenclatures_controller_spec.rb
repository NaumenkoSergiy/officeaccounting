require 'rails_helper'

RSpec.describe Purchases::NomenclaturesController, type: :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company) { FactoryGirl.create(:company) }
  let(:nomenclature_attributes) { FactoryGirl.attributes_for(:nomenclature, company_id: company.id) }
  let(:unvalid_nomenclature_attributes) do
    FactoryGirl.attributes_for(:nomenclature,
                               title: '',
                               type: '',
                               accounting_account_id: '',
                               guide_unit_id: '',
                               company_id: '',
                               count: '')
  end
  let!(:nomenclature) { FactoryGirl.create(:nomenclature) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do
    it { expect { post :create, nomenclature: nomenclature_attributes, format: :js }.to change(Nomenclature, :count).by(1) }
    it 'not add nomenclature for none current user', :skip_before do
      expect do
        post :create, nomenclature: nomenclature_attributes, format: :js
      end.to_not change(Nomenclature, :count)
    end
    it { expect { post :create, nomenclature: unvalid_nomenclature_attributes, format: :js }.to_not change(Nomenclature, :count) }
  end

  describe '#update' do
    let(:nomenclature_params) { { id: nomenclature.id, nomenclature: nomenclature_attributes, format: :json } }
    before do
      put :update, nomenclature_params
      nomenclature.reload
    end

    it { expect(nomenclature.title).to eql(nomenclature_attributes[:title]) }
    it { expect(nomenclature.type).to eql(nomenclature_attributes[:type]) }
    it { expect(nomenclature.guide_unit_id).to eql(nomenclature_attributes[:guide_unit_id]) }
    it { expect(nomenclature.accounting_account_id).to eql(nomenclature_attributes[:accounting_account_id]) }
  end

  describe '#destroy' do
    it { expect { delete :destroy, id: nomenclature.id, format: :js }.to change(Nomenclature, :count).by(-1) }
  end
end
