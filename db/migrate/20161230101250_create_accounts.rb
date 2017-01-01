class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :post, default: ""
      t.decimal :salary, precision: 8, scale: 2, default: 0
      t.datetime :joining_date, default: nil
      t.string :working_plan, default: nil
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
