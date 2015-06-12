require 'rails_helper'

RSpec.describe Department, type: :model do
  context "associations" do
    it { should belong_to(:company) }
    it { should have_many(:employees) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should_not allow_value('').for(:name) }
  end
end
