class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :log_id, :null => false, :options => 
        "CONSTRAINT fk_entry_logs REFERENCES logs(id)"
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
