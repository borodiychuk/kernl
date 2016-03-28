class AlterStorages1 < ActiveRecord::Migration
  def change
    add_column :storages, :public_creating_enabled, :boolean, :null => false, :default => false
  end
end
