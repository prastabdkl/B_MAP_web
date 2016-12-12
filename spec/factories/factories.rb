FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email { Faker::Internet.email(name) }
    password "password"
    password_confirmation "password"

    factory :is_admin do
      is_admin false
    end
  end
end
