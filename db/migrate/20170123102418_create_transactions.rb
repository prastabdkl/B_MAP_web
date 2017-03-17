class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.date :date, default: Date.today
      t.decimal :amount, precision: 8, scale: 2, default: 0.0
      t.string :cash_type
      t.references :capital, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
