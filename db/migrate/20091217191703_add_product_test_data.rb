class AddProductTestData < ActiveRecord::Migration
  def self.up
    Product.delete_all
    Product.create(:part_number => '1382');
    Product.create(:part_number => '1549');
    Product.create(:part_number => '1420');
    Product.create(:part_number => '6833');
    Product.create(:part_number => '5040');
  end

  def self.down
  end
end
