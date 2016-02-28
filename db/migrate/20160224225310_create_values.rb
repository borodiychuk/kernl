class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.json :data # Nullable, because it can actually be null
      t.timestamps :null => false
    end
    add_reference :values, :entry, :index => true, :foreign_key => {:on_delete => :cascade, :on_update => :cascade} # Nullable for ability to create values for nonexisting entries
    add_reference :values, :field, :null => false, :index => true, :foreign_key => {:on_delete => :cascade, :on_update => :cascade}
    add_index :values, [:entry_id, :field_id], :unique => true
  end
end
