class AddUserIdToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :user_id, :integer, :options => "CONSTRAINT fk_entry_users REFERENCES users(id)"
  end

  def self.down
    remove_column :entries, :user_id
  end
end
