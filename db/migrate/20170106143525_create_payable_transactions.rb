class CreatePayableTransactions < ActiveRecord::Migration
  def change
    create_table :payable_transactions do |t|
      t.date :date
      t.decimal :amount, precision: 8, scale:2
      t.string :cash_type
      t.references :payable, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
