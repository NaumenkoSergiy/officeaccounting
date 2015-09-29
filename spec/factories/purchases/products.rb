FactoryGirl.define do
  factory :product do
    number { Faker::Number.number(8) }
    title  { Faker::Name.name }
    amount { Faker::Number.number(3) }
    price { Faker::Number.number(4) }
    total { Faker::Number.number(3) }
    document_type { Product::DOCUMENT_TYPE[rand(2)] }
    date { Faker::Date.between(2.days.ago, Date.today) }
    document_number { Faker::Number.number(8) }
    document_date { Faker::Date.between(2.days.ago, Date.today) }
    currency { Currency::AVAILABLE_CURRENCIES[rand(23)] }
    conducted { [true, false].sample }

    before(:create) do |product|
        product.counterparty = FactoryGirl.create(:counterparty)
    end

    before(:create) do |product|
        product.guide_unit = FactoryGirl.create(:guide_unit)
    end

    before(:create) do |product|
        product.department = FactoryGirl.create(:department)
    end
  end
end
