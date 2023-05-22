class AddAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    t.boolean :admin, default: false
    add_column :users, :admin, :boolean, default: false


  end
end
