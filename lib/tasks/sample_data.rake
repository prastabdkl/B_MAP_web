namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example Admin", email: "admin@example.com", password: "password", password_confirmation: "password", is_admin: true, activated: true, activated_at: Time.zone.now, address: "address", bank_name: "bank_name", nationality: "nationality")

    99.times do |n|
      name = Faker::Name.name
      email = "user-#{n+1}@example.com"
      password = "password"
      address = Faker::Address.city
      bank_name = Faker::Bank.name
      nationality = Faker::Address.country
      account_number = Faker::Bank.iban
      User.create!(name: name, email: email, password: password, password_confirmation: password, is_admin: false, activated: true, activated_at: Time.zone.now, address: address, bank_name: bank_name, nationality: nationality, account_number: account_number)
    end
  end
end
