class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.boolean :enabled, :null => false, :default => false
      t.string  :title,       :null => false, :default => ""
      t.string  :subtitle,    :null => false, :default => ""
      t.string  :number,      :null => false, :default => ""
      t.text    :description

      t.timestamps :null => false
    end
    add_index :products, :enabled
    add_reference :products, :project, :null => false, :index => true, :foreign_key => {:on_delete => :cascade, :on_update => :cascade}
  end
end
