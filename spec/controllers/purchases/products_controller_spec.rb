require 'rails_helper'

RSpec.describe Purchases::ProductsController, type: :controller do
  let(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let(:company) { FactoryGirl.create(:company) }
  let(:product_attributes) do
    FactoryGirl.attributes_for(:product, counterparty: FactoryGirl.create(:counterparty),
                                         department: FactoryGirl.create(:department),
                                         guide_unit: FactoryGirl.create(:guide_unit))
  end
  let!(:product) { FactoryGirl.create(:product, company: company) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe '#create' do
    it { expect { post :create, product: product_attributes, format: :js }.to change(Product, :count).by(1) }

    it 'not add product for none current user', :skip_before do
      expect do
        post :create, product: product_attributes, format: :js
      end.to_not change(Product, :count)
    end
  end

  describe '#update' do
    context 'valid' do
      before do
        put :update, id: product.id, product: product_attributes, format: :json
        product.reload
      end

      it { expect(product.document_type).to eql(product_attributes[:document_type].to_s) }
      it { expect(product.date).to eql(product_attributes[:date]) }
      it { expect(product.number).to eql(product_attributes[:number].to_i) }
      it { expect(product.title).to eql(product_attributes[:title]) }
      it { expect(product.total).to eql(product_attributes[:total].to_f) }
      it { expect(product.conducted).to eql(product_attributes[:conducted]) }
    end

    context 'invalid' do
      let(:product_attributes) { FactoryGirl.attributes_for(:product, title: nil) }

      it 'has errors' do
        put :update, id: product.id, product: product_attributes, format: :json
        expect(response).to have_http_status(422)
      end
    end
  end

  describe '#destroy' do
    it { expect { delete :destroy, id: product.id, format: :js }.to change(Product, :count).by(-1) }
  end
end
