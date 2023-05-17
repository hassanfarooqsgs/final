class AddTosAgreementToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :tos_agreement, :boolean
  end
end
