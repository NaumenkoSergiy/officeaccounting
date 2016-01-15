require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  describe 'GET #new' do
    context 'user logged in' do
      before { session[:user_id] = user.id }

      it 'returns http success' do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context 'user logged out' do
      it 'returns http success' do
        get :new
        expect(response).to_not have_http_status(:success)
      end
    end
  end
end
