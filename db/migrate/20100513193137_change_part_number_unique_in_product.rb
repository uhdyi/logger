class ChangePartNumberUniqueInProduct < ActiveRecord::Migration
  def self.up
    change_column :products, :part_number, :string, :unique => true
  end

  def self.down
    change_column :products, :part_number, :string, :unique => false
  end
end
