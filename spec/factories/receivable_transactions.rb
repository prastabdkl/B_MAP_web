FactoryGirl.define do
  factory :receivable_transaction do
    date "2017-01-06"
    amount "9.99"
    cash_type "MyString"
    receivableables nil
  end
end
