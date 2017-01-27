FactoryGirl.define do
  factory :transaction do
    date "2017-01-23"
    amount "9.99"
    cash_type "MyString"
    capitals nil
  end
end
