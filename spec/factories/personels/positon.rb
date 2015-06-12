FactoryGirl.define do
  factory :position, :class => 'Position' do
    title { Faker::Name.name }
  end
end
