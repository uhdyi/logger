class AddCodeToLocation < ActiveRecord::Migration
  def self.up
    add_column :locations, :code, :string
  end

  def self.down
    remove_column :locations, :code
  end
end
