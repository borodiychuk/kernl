class AddEmailToAccount < ActiveRecord::Migration
  def up
    add_column :accounts, :email, :string
    execute <<-SQL
      UPDATE accounts SET email = CONCAT(id, '.accounts@kernl.rocks')
    SQL
    change_column :accounts, :email, :string, :null => false
  end

  def down
    remove_column :accounts, :email
  end

end
