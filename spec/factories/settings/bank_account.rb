FactoryGirl.define do
  factory :bank_account do
    account { Faker::Number.number(8)      }
    mfo     { Faker::Number.number(8)      }
    bank    { Faker::Commerce.product_name }
  end

  factory :unvalid_bank_account, class: BankAccount do; end
end
