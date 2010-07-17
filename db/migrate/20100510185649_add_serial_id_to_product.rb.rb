class AddSerialIdToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :serial_id, :integer
  end

  def self.down
    remove_column :products, :serial_id
  end
end
