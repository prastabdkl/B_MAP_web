FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email { Faker::Internet.email(name) }
    password "password"
    password_confirmation "password"
    activated true
    activated_at Date.new(2012, 5, 5)

    factory :is_admin do
      is_admin false
    end
  end
end
