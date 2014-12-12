FactoryGirl.define do
  factory :company do
    full_name         { Faker::Company.name           }
    short_name        { Faker::Company.suffix         }
    latin_name        { Faker::Company.name           }
    juridical_address { Faker::Address.street_address }
    numbering_format  { Faker::Number.number(3)       }
  end

  factory :unvalid_company, class: Company do; end
end
