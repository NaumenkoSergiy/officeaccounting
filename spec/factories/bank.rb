# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bank, :class => 'Bank' do
    name { Faker::Name.name } 
    code_edrpo { Faker::Number.number(8) }
    mfo { Faker::Number.number(8) }
    lawyer_adress { Faker::Address.country }
  end
end
