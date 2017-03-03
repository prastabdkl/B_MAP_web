class AddNewCreatedAndUpdatedFieldToAllModels < ActiveRecord::Migration
  def change
    add_column :users, :updated, :boolean, default: false
    add_column :users, :new_created, :boolean, default: true
    add_column :accounts, :new_created, :boolean, default: true
    add_column :accounts, :updated, :boolean, default: false
    add_column :capitals, :new_created, :boolean, default: true
    add_column :capitals, :updated, :boolean, default: false
    add_column :transactions, :new_created, :boolean, default: true
    add_column :transactions, :updated, :boolean, default: false
  end
end
