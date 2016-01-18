class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string   :name, :null => false, :default => ""
      t.string   :email, :null => false
      t.string   :encrypted_password, :null => false, :default => ""
      ## Rememberable
      t.datetime :remember_created_at
      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip
      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid
      ## Tokens
      t.json :tokens

      t.timestamps :null => false
    end
    add_index :users, :email, :unique => true
    add_reference :users, :account, :null => false, :index => true, :foreign_key => {:on_delete => :cascade, :on_update => :cascade}
  end
end
