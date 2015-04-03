require 'rails_helper'

RSpec.describe GuideUnit, type: :model do
  describe 'validation rules' do
    it { should validate_presence_of(:name) }
    it { should_not allow_value('').for(:name) }

    it { should belong_to(:user) }
  end
end
