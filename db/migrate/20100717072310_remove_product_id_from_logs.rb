class RemoveProductIdFromLogs < ActiveRecord::Migration
  def self.up
    remove_column :logs, :product_id
  end

  def self.down
    add_column :logs, :product_id
  end
end
