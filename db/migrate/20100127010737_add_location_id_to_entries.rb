class AddLocationIdToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :location_id, :integer, :options => "CONSTRAINT fk_entry_locations REFERENCES locations(id)"
  end

  def self.down
    remove_column :entries, :location_id
  end
end
