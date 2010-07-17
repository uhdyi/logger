class RemoveEntryIdFromLog < ActiveRecord::Migration
  def self.up
    remove_column :logs, :entry_id
  end

  def self.down
    add_column :logs, :entry_id
  end
end
