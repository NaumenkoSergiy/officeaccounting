FactoryGirl.define do
  factory :employee, class: 'Employee' do
    personnel_number { Faker::Number.number(6)                                     }
    type             { 'Employee::' + Employee::TYPES[rand(2)].to_s                }
    name             { Faker::Name.name                                            }
    passport         { Faker::Address.country_code + ' ' + Faker::Number.number(6) }
    adress           { Faker::Address.street_address                               }
    date_birth       { Faker::Date.backward(20_000) }
    ipn              { Faker::Number.number(10)                                    }
    department_id    { FactoryGirl.create(:department).id                          }
    position_id      { FactoryGirl.create(:position).id                            }
  end
end
