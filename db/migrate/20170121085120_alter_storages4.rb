class AlterStorages4 < ActiveRecord::Migration
  def change
    add_column :storages, :recaptcha_protected, :boolean, :null => false, :default => false
    add_column :storages, :recaptcha_secret_key, :string, :null => false, :default => ""
  end
end
