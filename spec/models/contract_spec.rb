require 'rails_helper'

RSpec.describe Contract, type: :model do
  describe 'validation rules' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:validity) }
    it { should allow_value(Faker::Number.number(8)).for(:number) }
    it { should_not allow_value('').for(:number) }
  end
end
