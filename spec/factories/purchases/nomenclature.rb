FactoryGirl.define do
  factory :nomenclature do
    title { Faker::Name.name }
    type { Nomenclature.subclasses.map{ |s| s.name }[rand(4)] }
    guide_unit_id { Faker::Number.number(3).to_i }
    accounting_account_id { Faker::Number.number(3).to_i }
    count { Faker::Number.number(2).to_f }
  end
end
