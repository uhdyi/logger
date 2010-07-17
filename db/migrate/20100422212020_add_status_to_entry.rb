class AddStatusToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :status_id, :integer, :options => "CONSTRAINT fk_entry_statuses REFERENCES statuses(id)"
  end

  def self.down
    remove_column :entries, :status_id
  end
end
