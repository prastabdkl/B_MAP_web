namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example Admin", email: "admin@example.com", password: "password", password_confirmation: "password", is_admin: true, activated: false, activated_at: Time.zone.now)

    99.times do |n|
      name = Faker::Name.name
      email = "user-#{n+1}@example.com"
      password = "password"
      User.create!(name: name, email: email, password: password, password_confirmation: password, is_admin: false, activated: true, activated_at: Time.zone.now)
    end
  end
end
