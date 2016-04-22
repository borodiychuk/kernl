class AlterEntries1 < ActiveRecord::Migration
  def change
    add_column :entries, :creator_ip, :string, :default => "0.0.0.0"
  end
end
