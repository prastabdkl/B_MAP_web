class AddAdditionAndDeductionToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :addition_holiday, :decimal, precision: 8, scale: 2, default: 0
    add_column :accounts, :addition_overtime, :decimal, precision: 8, scale: 2, default: 0
    add_column :accounts, :addition_miscellaneous, :decimal, precision: 8, scale: 2, default: 0
    add_column :accounts, :deduction_loan, :decimal, precision: 8, scale: 2, default: 0
    add_column :accounts, :deduction_late, :decimal, precision: 8, scale: 2, default: 0
    add_column :accounts, :deduction_miscellaneous, :decimal, precision: 8, scale: 2, default: 0
    add_column :accounts, :company_deduction_absent, :decimal, precision: 8, scale: 2, default: 0
    add_column :accounts, :company_deduction_wtax, :decimal, precision: 8, scale: 2, default: 10
    add_column :accounts, :net_total_addition, :decimal, precision: 8, scale: 2, default: 0
    add_column :accounts, :net_total_deduction, :decimal, precision: 8, scale: 2, default: 0
    add_column :accounts, :net_pay, :decimal, precision: 8, scale: 2
  end
end
