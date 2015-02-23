require "rails_helper"
RSpec.describe SettingsHelper, type: :helper do
  let!(:date) { Faker::Date.forward(23) }
  describe "#date_localization" do
    it "returns empty string" do
      expect(helper.ldate(nil)).to eq("")
    end

    it "returns localize date" do
      hash = { :format=>:default }
      expect(helper.ldate(date, hash)).to eq(l(date, hash))
    end
  end
end
