FactoryGirl.define do
  factory :payable do
    date "2017-01-04"
    name "MyString"
    description "MyText"
    phone_no "MyString"
    address "MyString"
    img "MyString"
    Amount "9.99"
    user nil
  end
end
