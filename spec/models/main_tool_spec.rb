require 'rails_helper'

RSpec.describe MainTool, type: :model do
  describe 'validation rules' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:title) }
    it { should_not allow_value('').for(:title) }

    it { should belong_to(:company) }
  end
end
