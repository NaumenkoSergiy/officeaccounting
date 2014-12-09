require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  context 'session' do
    let(:user) { FactoryGirl.create(:user, activate_token: nil) }
    let(:unconfirmed_user) { FactoryGirl.create(:user, activate_token: SecureRandom.hex) }
    let(:none_user) { FactoryGirl.attributes_for(:user)}
    let(:admin) { FactoryGirl.create(:user, is_admin: true, activate_token: nil)}
    let(:unconfirmed_admin) { FactoryGirl.create(:user, is_admin: true, activate_token: SecureRandom.hex)}

    describe '#create' do
      it 'create new session' do
        post :create, email: user.email, password: user.password, format: :js
        expect(session[:user_id]).to equal user.id
      end

      it 'create new admin session' do
        post :create, email: admin.email, password: admin.password, format: :js
        expect(session[:user_id]).to equal admin.id
        expect(admin.is_admin).to be_truthy
      end

      it 'failed create new session' do
        post :create, email: unconfirmed_user.email,
                      password: unconfirmed_user.password,
                      format: :js
        expect(session[:user_id]).to be_nil
      end

      it 'failed create new admin session' do
        post :create, email: unconfirmed_admin.email,
                      password: unconfirmed_admin.password,
                      format: :js
        expect(session[:user_id]).to be_nil
        expect(unconfirmed_admin.is_admin).to be_truthy
      end

      it 'failed create new session' do
        post :create, email: none_user[:email],
                      password: none_user[:password],
                      format: :js
        expect(session[:user_id]).to be_nil
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
