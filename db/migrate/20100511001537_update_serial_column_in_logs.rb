class UpdateSerialColumnInLogs < ActiveRecord::Migration
  def self.up
    remove_column :logs, :serial_number
    add_column :logs, :serial_id, :integer, :options => "CONSTRAINT fk_log_serials REFERENCES serials(id)"
  end

  def self.down
    add_column :logs, :serial_number
    remove_column :logs, :serial_id
  end
end
