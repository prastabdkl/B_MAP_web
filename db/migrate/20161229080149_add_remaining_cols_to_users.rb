class AddRemainingColsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :bank_name, :string
    add_column :users, :account_number, :string
    add_column :users, :nationality, :string
    add_column :users, :mobile, :string
    add_column :users, :home, :string
    add_column :users, :work, :string
  end
end
