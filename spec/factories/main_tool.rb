FactoryGirl.define do
  factory :main_tool do
    title { Faker::Name.name }
    type { 'MainTool::' + MainTool::TYPES[rand(4)].to_s }
    serial_number { Faker::Number.number(8) }
    passport_number { Faker::Number.number(8) }
    date { Faker::Date.forward(23) }
    brand { Faker::Name.name }
  end
end
