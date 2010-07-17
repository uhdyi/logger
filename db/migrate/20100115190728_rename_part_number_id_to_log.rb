class RenamePartNumberIdToLog < ActiveRecord::Migration
  def self.up
    rename_column :logs, :part_number_id, :product_id
  end

  def self.down
  end
end
