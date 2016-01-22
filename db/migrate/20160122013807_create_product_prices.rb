class CreateProductPrices < ActiveRecord::Migration
  def change
    create_table :product_prices do |t|
      t.integer :amount                               # Nullable for initial creation
      t.decimal :price,  :precision => 8, :scale => 2 # Nullable for initial creation

      t.timestamps :null => false
    end
    add_reference :product_prices, :product, :null => false, :index => true, :foreign_key => {:on_delete => :cascade, :on_update => :cascade}
    add_index :product_prices, :price
    add_index :product_prices, [:product_id, :amount], :unique => true
  end
end
