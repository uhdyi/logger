class SetDefaultToAdminToUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :admin
    add_column :users, :admin, :boolean, :default => false
  end

  def self.down
    remove_column :users, :admin
  end
end
