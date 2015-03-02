FactoryGirl.define do
  factory :bank_account do
    account { Faker::Number.number(8)      }
    mfo     { Faker::Number.number(8)      }
    bank_id { Faker::Number.number(2)      }
  end

  factory :unvalid_bank_account, class: BankAccount do
    account { nil }
    mfo     { nil }
    bank_id { nil }
  end
end
