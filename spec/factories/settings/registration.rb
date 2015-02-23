FactoryGirl.define do
  factory :registration do
    form_of_incorporation { '100 Підприємство' }
    edrpou { Faker::Number.number(8) }
    nace_codes { Faker::Number.number(10) }
    koatuu { Faker::Number.number(8) }
    risk_class { Faker::Number.number(2) }
    tin { Faker::Number.number(8) }
    state_registration_date { Faker::Date.between(2.month.ago, Date.yesterday) }
    registration_number { Faker::Number.number(10) }
    registered_by { Faker::Name.name }
    date_registered_in_revenue_commissioners { Faker::Date.between(2.month.ago, Date.yesterday) }
    number_registered_in_revenue_commissioners { Faker::Number.number(10) }
    registered_in_pension_fund { Faker::Date.between(2.month.ago, Date.yesterday) }
    code_registered_in_pension_fund { Faker::Number.number(8) }
    tax_system { ['Загальна', 'Спрощена'][rand(2)] }
  end

  factory :unvalid_registration, class: Registration do
    form_of_incorporation { nil }
    edrpou { Faker::Name.name }
    nace_codes { Faker::Name.name }
    koatuu { Faker::Name.name }
    risk_class { Faker::Name.name }
    tin { Faker::Name.name }
    state_registration_date { nil }
    registration_number { nil }
    registered_by { nil }
    date_registered_in_revenue_commissioners { nil }
    number_registered_in_revenue_commissioners { nil }
    registered_in_pension_fund { nil }
    code_registered_in_pension_fund { nil }
    tax_system { nil }
  end
end
