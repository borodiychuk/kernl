class AlterFields2 < ActiveRecord::Migration
  def change
    add_column :fields, :options, :json # Nullable, because it is defined in differnt ways
  end
end
