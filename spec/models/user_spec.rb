require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation email' do
    let(:user) { FactoryGirl.create(:user) }

    describe 'unvalid email validation' do
      it 'has unvalid email' do
        user.email = 'user@foo,com'
        expect(user).to be_invalid
      end

      it 'has unvalid email' do
        user.email = 'user_at_foo.org'
        expect(user).to be_invalid
      end

      it 'has unvalid email' do
        user.email = 'example.user@foo.'
        expect(user).to be_invalid
      end

      it 'has unvalid email' do
        user.email = 'foo@bar_baz.com'
        expect(user).to be_invalid
      end

      it 'has unvalid email' do
        user.email = 'foo@bar+baz.com'
        expect(user).to be_invalid
      end
    end

    describe 'valid email validation' do
      it 'has valid email' do
        user.email = 'email@example.com'
        expect(user).to be_valid
      end

      it 'has valid email' do
        user.email = 'firstname.lastname@example.com'
        expect(user).to be_valid
      end

      it 'has valid email' do
        user.email = 'email@subdomain.example.com'
        expect(user).to be_valid
      end

      it 'has valid email' do
        user.email = 'firstname+lastname@example.com'
        expect(user).to be_valid
      end
    end
  end

  context 'password' do
    let(:user) { FactoryGirl.create(:user) }

    it 'has unvalid password' do
      user.password = Faker::Internet.password(33)
      expect(user).to be_invalid
    end

    it 'has unvalid password' do
      user.password = Faker::Internet.password(5)
      expect(user).to be_invalid
    end

    it 'has valid password' do
      user.password = Faker::Internet.password(6, 32)
      expect(user).to be_invalid
    end

    it 'has confirm password not equal to password and unvalid user' do
      user.password = Faker::Internet.password
      user.password_confirmation = Faker::Internet.password
      expect(user).to be_invalid
    end

    it 'has confirm password equal to password and valid user' do
      user.password = Faker::Internet.password
      user.password_confirmation = user.password
      expect(user).to be_valid
    end
  end

  it { should have_many(:user_companies) }
  it { should have_many(:companies) }
  it { should delegate_method(:accounts).to(:current_company) }
  it { should delegate_method(:contracts).to(:current_company) }
  it { should delegate_method(:counterparties).to(:current_company) }
  it { should delegate_method(:money_registers).to(:current_company) }
  it { should delegate_method(:currencies).to(:current_company) }
  it { should delegate_method(:cashiers).to(:current_company) }
  it { should delegate_method(:credits).to(:current_company) }
  it { should delegate_method(:payment_orders).to(:current_company) }
  it { should delegate_method(:id).to(:current_company).with_prefix(true) }
  it { should delegate_method(:short_name).to(:current_company).with_prefix(true) }
end
