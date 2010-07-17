class AddDetailToLocation < ActiveRecord::Migration
  def self.up
    add_column :locations, :detail, :string
  end

  def self.down
    remove_column :locations, :detail
  end
end
