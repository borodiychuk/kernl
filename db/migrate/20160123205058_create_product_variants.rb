class CreateProductVariants < ActiveRecord::Migration
  def change
    create_table :product_variants do |t|
      t.string :name  # Nullable for initial creation
      t.string :value # Nullable for initial creation

      t.timestamps :null => false
    end
    add_reference :product_variants, :product, :null => false, :index => true, :foreign_key => {:on_delete => :cascade, :on_update => :cascade}
    add_index :product_variants, :name
    add_index :product_variants, [:product_id, :name], :unique => true
  end
end
