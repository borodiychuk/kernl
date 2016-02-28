class AlterFields1 < ActiveRecord::Migration
  def change
    add_column :fields, :shown_in_backend_list, :boolean, :null => false, :default => false
  end
end
