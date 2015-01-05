# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bank, :class => 'Banks' do
    name "MyString"
    code_edrpo 1
    mfo 1
    lawyer_adress "MyString"
  end
end
