namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # creating admin user
    admin = User.create!(name: "Example Admin",
                         email: "admin@example.com",
                         password: "password",
                         password_confirmation: "password",
                         is_admin: true,
                         activated: true,
                         activated_at: Time.zone.now,
                         address: "Dhulikhel",
                         bank_name: "NIC Asia",
                         account_number: "***",
                         nationality: "Nepali",
                         mobile: "(+977)98********",
                         new_created: true,
                         updated: false)
    account = Account.create!(post: "Manager",
                              salary: "50000.00",
                              joining_date: Time.zone.now,
                              working_plan: "full",
                              new_created: true,
                              updated: false)
    account.update_attribute(:net_total_addition, account.addition_holiday + account.addition_overtime + account.addition_miscellaneous)
    account.update_attribute(:net_total_deduction, account.company_deduction_absent + (account.company_deduction_wtax * account.salary / 100) + account.deduction_late + account.deduction_loan + account.deduction_miscellaneous)
    account.update_attribute(:net_pay, account.salary + account.net_total_addition - account.net_total_deduction)
    admin.account = account

    # creating other users
    29.times do |n|
      # these data are for user model
      name = Faker::Name.name
      email = "user-#{n+1}@example.com"
      password = "password"
      address = Faker::Address.city
      bank_name = Faker::Bank.name
      nationality = Faker::Address.country
      account_number = Faker::Business.credit_card_number
      account_number = Faker::Business.credit_card_number
      nationality = Faker::Address.country
      mobile = Faker::Base.numerify('(+977) 98########')
      home = Faker::Base.numerify('(0##) 66#####')
      work = Faker::Base.numerify('(011) 66#####')

      # these data are for account model
      post = Faker::Company.profession
      salary = Faker::Base.numerify('######.##  ')
      joining_date = Faker::Date.between(10.days.ago, Date.today)
      working_plan = "Full"
      user = User.create!(name: name,
                          email: email,
                          password: password,
                          password_confirmation: password,
                          is_admin: false,
                          activated: true,
                          activated_at: Time.zone.now,
                          address: address,
                          bank_name: bank_name,
                          account_number: account_number,
                          nationality: nationality,
                          mobile: mobile,
                          home: home,
                          work: work,
                          new_created: true,
                          updated: false)
      account = Account.create!(post: post,
                                salary: salary,
                                joining_date: joining_date,
                                working_plan: working_plan,
                                new_created: true,
                                updated: false)
      account.update_attribute(:net_total_addition, account.addition_holiday + account.addition_overtime + account.addition_miscellaneous)
      account.update_attribute(:net_total_deduction, account.company_deduction_absent + (account.company_deduction_wtax * account.salary / 100) + account.deduction_late + account.deduction_loan + account.deduction_miscellaneous)
      account.update_attribute(:net_pay, account.salary + account.net_total_addition - account.net_total_deduction)
      user.account = account
    end
  end
end
