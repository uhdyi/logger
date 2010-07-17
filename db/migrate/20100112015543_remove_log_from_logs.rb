class RemoveLogFromLogs < ActiveRecord::Migration
  def self.up
    remove_column :logs, :log
  end

  def self.down
  end
end
