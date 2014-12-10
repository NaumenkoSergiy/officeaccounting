FactoryGirl.define do
  factory :company do
    full_name { Faker::Company.name }
    short_name { Faker::Company.suffix }
    latin_name { Faker::Company.name }
    juridical_address { Faker::Address.street_address }
    numbering_format { '123' }
  end

  factory :unvalid_company, class: Company do
    full_name { '' }
    short_name { '' }
    latin_name { '' }
    juridical_address { '' }
    numbering_format { '' }
  end
end
