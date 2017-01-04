class CreateReceivables < ActiveRecord::Migration
  def change
    create_table :receivables do |t|
      t.date :date
      t.string :name
      t.text :description
      t.string :phone_no
      t.string :address
      t.string :img
      t.decimal :amount, precision: 8, scale:2
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
