require 'rails_helper'

RSpec.describe Employee, type: :model do
  context "associations" do
    it { should belong_to(:company) }
    it { should belong_to(:department) }
    it { should belong_to(:position) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:personnel_number) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:date_birth) }
    it { should validate_presence_of(:passport) }
    it { should validate_presence_of(:ipn) }
    it { should validate_presence_of(:adress) }
    it { should validate_presence_of(:department_id) }
    it { should validate_presence_of(:position_id) }
    it { should_not allow_value('').for(:name) }
    it { should_not allow_value('').for(:personnel_number) }
    it { should_not allow_value('').for(:type) }
    it { should_not allow_value('').for(:date_birth) }
    it { should_not allow_value('').for(:passport) }
    it { should_not allow_value('').for(:ipn) }
    it { should_not allow_value('').for(:adress) }
    it { should_not allow_value('').for(:department_id) }
    it { should_not allow_value('').for(:position_id) }
  end

  describe "delegation" do
    it { should delegate_method(:name).to(:department).with_prefix(true) }
    it { should delegate_method(:title).to(:position).with_prefix(true) }
  end
end
