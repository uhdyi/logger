class AddProductIdToSerial < ActiveRecord::Migration
  def self.up
    
    add_column :serials, :product_id, :integer, :options => "CONSTRAINT fk_serial_products REFERENCES products(id)" 
  end

  def self.down
    remove_column :serials, :product_id
  end
end
