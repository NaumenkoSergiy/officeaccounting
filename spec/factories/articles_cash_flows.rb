# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :articles_cash_flow, :class => 'ArticlesCashFlows' do
    code 1
    name "MyString"
  end
end
