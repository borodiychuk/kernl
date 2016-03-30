class AlterStorages2 < ActiveRecord::Migration
  def change
    add_column :storages, :public_viewing_enabled, :boolean, :null => false, :default => false
  end
end
