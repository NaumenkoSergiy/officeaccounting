require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#create' do
    let!(:user_attributes) { FactoryGirl.attributes_for(:user) }

    it 'create new user' do
      expect do
        post :create, user_attributes
      end.to change(User, :count).by(1)
    end
  end
end
