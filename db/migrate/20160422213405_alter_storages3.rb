class AlterStorages3 < ActiveRecord::Migration
  def change
    add_column :storages, :email_notification_on_public_creation_enabled, :boolean, :null => false, :default => false
  end
end
