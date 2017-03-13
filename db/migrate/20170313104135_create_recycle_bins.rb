class CreateRecycleBins < ActiveRecord::Migration
  def change
    create_table :recycle_bins do |t|
      t.string :table_name
      t.integer :corr_id

      t.timestamps null: false
    end
  end
end
