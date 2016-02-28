class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.boolean    :enabled, :null => false, :default => false

      t.timestamps :null => false
    end
    add_reference :entries, :storage, :null => false, :index => true, :foreign_key => {:on_delete => :cascade, :on_update => :cascade}
  end
end
