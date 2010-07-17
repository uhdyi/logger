class RemoveColumnsFromLog < ActiveRecord::Migration
  def self.up
    remove_column :logs, :status_id
    remove_column :logs, :location_id
    remove_column :logs, :user_id
  end

  def self.down
    add_column :logs, :status_id
    add_column :logs, :location_id
    add_column :logs, :user_id
  end
end
