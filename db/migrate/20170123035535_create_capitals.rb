# migration file for handeling the financial related data
class CreateCapitals < ActiveRecord::Migration
  def change
    create_table :capitals do |t|
      t.string :name
      t.text :description
      t.string :phone_no
      t.string :address
      t.decimal :total_amount, precision: 8, scale: 2
      t.string :capital_type
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
