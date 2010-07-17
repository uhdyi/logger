class AddEntryIdToLogs < ActiveRecord::Migration
  def self.up
    add_column :logs, :entry_id, :integer, :null => false, :options => 
      "CONSTRAINT fk_entry_logs REFERENCES logs(id)"
  end

  def self.down
    remove_column :logs, :entry_id
  end
end
