class Api::V1::AccountSerializer < Api::V1::BaseSerializer
  attributes :id, :post, :salary, :joining_date, :working_plan,
              :addition_holiday, :addition_overtime, :addition_miscellaneous,
              :deduction_loan, :deduction_late, :deduction_miscellaneous,
              :company_deduction_absent, :company_deduction_wtax, :net_total_addition,
              :net_total_deduction, :net_pay, :new_created, :updated

  has_one :user
end
