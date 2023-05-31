class CreateCamps < ActiveRecord::Migration[6.0]
  def change
    create_table :camps do |t|
      t.string :title
      t.string :location

      t.timestamps
    end
  end
end
