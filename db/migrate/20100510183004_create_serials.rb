class CreateSerials < ActiveRecord::Migration
  def self.up
    create_table :serials do |t|
      t.string :serial_number

      t.timestamps
    end
  end

  def self.down
    drop_table :serials
  end
end
