class CreateStorages < ActiveRecord::Migration
  def change
    create_table :storages do |t|
      t.string :name, :null => false

      t.timestamps :null => false
    end
    add_reference :storages, :account, :null => false, :index => true, :foreign_key => {:on_delete => :cascade, :on_update => :cascade}
  end
end
