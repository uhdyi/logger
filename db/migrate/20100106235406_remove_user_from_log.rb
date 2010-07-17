class RemoveUserFromLog < ActiveRecord::Migration
  def self.up
    remove_column :logs, :user
    add_column :logs, :user_id, :integer
  end

  def self.down
    remove_column :logs, :user_id
  end
end
