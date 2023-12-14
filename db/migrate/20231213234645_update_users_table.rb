class UpdateUsersTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :address, :string
    remove_column :users, :province, :string
    remove_column :users, :city, :string

    add_reference :users, :location, foreign_key: true
  end
end
