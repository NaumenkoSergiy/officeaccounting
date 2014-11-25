require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  context 'session' do
    let(:user) { FactoryGirl.create(:user) }

    describe '#create' do
      it 'create new session' do
        post :create, { email: user.email, password: user.password } 
        expect(session[:user_id]).to equal user.id
      end
    end

    describe '#destroy' do
      it 'destroy current user' do
        delete :destroy, id: user.id 
        expect(session[:user_id]).to be_nil
      end
    end
  end

end
