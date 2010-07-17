class AddForeignKeyToProduct < ActiveRecord::Migration
  def self.up
    remove_column :products, :serial_id
    add_column :products, :serial_id, :integer, :options => "CONSTRAINT fk_entry_serials REFERENCES serials(id)"
  end

  def self.down
    remove_column :products, :serial_id
  end
end
