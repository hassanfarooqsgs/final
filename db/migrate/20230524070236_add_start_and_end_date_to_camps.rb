class AddStartAndEndDateToCamps < ActiveRecord::Migration[6.0]
  def change
    add_column :camps, :start_date, :date
    add_column :camps, :end_date, :date
  end
end
