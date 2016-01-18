class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|

      t.timestamps :null => false
    end
    add_reference :products, :project, :null => false, :index => true, :foreign_key => {:on_delete => :cascade, :on_update => :cascade}
  end
end
