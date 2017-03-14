class AddUserIdColumnToRecycleBin < ActiveRecord::Migration
  def change
    add_column :recycle_bins, :user_id, :integer
  end
end
