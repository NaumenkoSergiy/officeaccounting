FactoryGirl.define do
  factory :guide_unit, class: 'GuideUnit' do
    name { Faker::Name.name }
  end
end
