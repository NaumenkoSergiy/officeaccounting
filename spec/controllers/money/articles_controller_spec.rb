require 'rails_helper'

RSpec.describe Money::ArticlesController, type: :controller do
  let!(:user) { FactoryGirl.create(:user, activate_token: nil) }
  let!(:company) { FactoryGirl.create(:company) }
  let!(:article_attributes) { FactoryGirl.attributes_for(:article) }
  let!(:unvalid_article_attributes) { FactoryGirl.attributes_for(:article, name: '') }
  let!(:article) { FactoryGirl.create(:article) }

  before(:each) do |test|
    FactoryGirl.create(:user_company, company: company, user: user, current_company: true)
    session[:user_id] = user.id unless test.metadata[:skip_before]
  end

  describe '#create' do
    it 'add article' do
      expect do
        post :create, { article: article_attributes }.merge!(format: :js)
      end.to change(Article, :count).by(1)
    end

    it 'not add article for none current user', :skip_before do
      expect do
        post :create, { article: article_attributes }.merge!(format: :js)
      end.to_not change(Article, :count)
    end

    it 'add article from unvalid article attributes' do
      expect do
        post :create, { article: unvalid_article_attributes }.merge!(format: :js)
      end.to_not change(Article, :count)
    end

    it 'not add article with empty attributes' do
      expect do
        post :create, { article: unvalid_article_attributes }.merge!(format: :js)
      end.to_not change(Article, :count)
    end
  end

  describe '#update' do
    before do
      put :update, { id: article.id, article: article_attributes }.merge!(format: :json)
      article.reload
    end
    it { expect(article.name).to eql(article_attributes[:name]) }
  end

  describe '#destroy' do
    it 'destroy article' do
      expect do
        delete :destroy, { id: article.id }.merge!(format: :js)
      end.to change(Article, :count).by(-1)
    end
  end
end
