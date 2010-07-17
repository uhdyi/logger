class RemoveSerialIdFromProduct < ActiveRecord::Migration
  def self.up
    remove_column :products, :serial_id
  end

  def self.down
    add_column :products, :serial_id
  end
end
