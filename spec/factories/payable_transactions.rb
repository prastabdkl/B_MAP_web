FactoryGirl.define do
  factory :payable_transaction do
    date "2017-01-06"
    amount "9.99"
    cash_type "MyString"
    payables nil
  end
end
