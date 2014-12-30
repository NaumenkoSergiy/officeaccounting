require 'rails_helper'

RSpec.describe PasswordResetsController, :type => :controller do
    
  before(:all) do
    @user = FactoryGirl.create(:user)
    @user.update_attribute(:activate_token, nil)
  end

  describe '#create' do
    let!(:user_attributes) { FactoryGirl.attributes_for(:user) }

    it 'create password_resets' do
      post :create, email: @user.email
      expect(User.last.password_reset_token).to_not be_nil
    end
  end
end
