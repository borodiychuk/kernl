class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string  :file_uid  # Nullable
      t.string  :file_name # Nullable
      t.integer :ordering  # Nullable

      t.timestamps null: false
    end
    add_reference :attachments, :value, :null => false, :index => true, :foreign_key => {:on_delete => :cascade, :on_update => :cascade}
  end
end
