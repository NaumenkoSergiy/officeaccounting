FactoryGirl.define do
  factory :department, :class => 'Department' do
    name { Faker::Name.name }
  end
end
