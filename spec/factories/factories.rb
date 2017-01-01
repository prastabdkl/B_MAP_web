FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email { Faker::Internet.email(name) }
    password "password"
    password_confirmation "password"
    activated true
    activated_at Date.new(2012, 5, 5)
    address Faker::Address.city
    bank_name Faker::Bank.name
    nationality Faker::Address.country
    #account_number Faker::Bank.iban

    factory :is_admin do
      is_admin false
    end
  end
end
