class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|

      t.string     :file_uid,  :null => false
      t.string     :file_name, :null => false
      t.integer    :ordering,   :null => false, :default => 0

      t.timestamps :null => false
    end
    add_reference :images, :product, :index => true, :null => false, :foreign_key => {:on_delete => :cascade, :on_update => :cascade}
  end
end
