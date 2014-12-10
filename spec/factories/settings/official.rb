FactoryGirl.define do
  factory :official do
    official_type do
      ['Директор', 'Бухгалтер'][rand(2)]
    end
    name  { Faker::Name.name              }
    tin   { Faker::Number.number(8)       }
    phone { Faker::PhoneNumber.cell_phone }
    email { Faker::Internet.email         }
  end

  factory :unvalid_official, class: Official do; end
end
