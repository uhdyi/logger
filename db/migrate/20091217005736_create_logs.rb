class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table :logs do |t|
      t.integer :part_number_id, :null => false, :options => "CONSTRAINT fk_logs_products REFERENCES products(id)"
      t.string :serial_number
      t.text :log
      t.string :user

      t.timestamps
    end
  end

  def self.down
    drop_table :logs
  end
end
