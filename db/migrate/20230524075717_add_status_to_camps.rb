class AddStatusToCamps < ActiveRecord::Migration[6.0]
  def change
    add_column :camps, :status, :string
  end
end
