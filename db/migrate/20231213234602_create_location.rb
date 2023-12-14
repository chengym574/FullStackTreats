class CreateLocation < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :province
      t.string :city
      t.string :address

      t.timestamps
    end
  end
end
