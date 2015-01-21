require 'rails_helper'

RSpec.describe Registration, :type => :model do
	context 'validation pension fund' do
		let!(:company) { FactoryGirl.create(:company) }
		let(:registration) { FactoryGirl.create(:registration, company_id: company.id) }

		describe 'valid pension fund validation' do
			it 'has valid code registration in pension fund' do
				registration.code_registered_in_pension_fund = ''
				expect(registration).to be_valid
			end

			it 'has valid code registration in pension fund' do
				registration.code_registered_in_pension_fund = '123456'
				expect(registration).to be_valid
			end
		end

		describe 'unvalid pension fund validation' do
			it 'has unvalid code registration pension fund' do
				registration.code_registered_in_pension_fund = 'fhdjdfksl'
				expect(registration).to be_invalid
			end
		end
	end
end
