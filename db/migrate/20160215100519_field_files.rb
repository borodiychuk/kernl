class FieldFiles < ActiveRecord::Migration
  def change
    create_table :field_files do |t|
      t.string     :file_uid,  :null => false
      t.string     :file_name, :null => false
      t.text       :description

      t.timestamps :null => false
    end
    add_reference :field_files, :project, :null => false, :index => true, :foreign_key => {:on_delete => :cascade, :on_update => :cascade}
  end
end
