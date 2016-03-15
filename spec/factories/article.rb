# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article, class: 'Article' do
    name { Faker::Name.name }
  end
end
