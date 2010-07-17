class AddColumnsToLogs < ActiveRecord::Migration
  def self.up
    add_column :logs, :status_id, :integer, :opitons => "CONSTRAINT fk_log_statuses REFERENCES statuses(id)"
    add_column :logs, :location_id, :integer, :options => "CONSTRAINT fk_log_locations REFERENCES locations(id)"
    add_column :logs, :user_id, :integer, :options => "CONSTRAINT fk_log_users REFERENCES users(id)"
  end

  def self.down
    remove_column :logs, :status_id
    remove_column :logs, :location_id
    remove_column :logs, :user_id
  end
end
