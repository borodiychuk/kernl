class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|

      t.string  :identifier, :null => false
      t.string  :name,       :null => false

      # Service fields
      t.string  :type, :null => false
      t.integer :ordering # Nullable, why not
      t.timestamps :null => false
    end
    add_reference :fields, :storage, :null => false, :index => true, :foreign_key => {:on_delete => :cascade, :on_update => :cascade}
    add_index :fields, [:storage_id, :identifier], :unique => true
  end
end
