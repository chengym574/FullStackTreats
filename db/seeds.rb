require 'faker'
require 'csv'

OrderItem.delete_all
Order.delete_all
Product.delete_all
Category.delete_all
# User.delete_all

ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='order_items';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='orders';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='products';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='categories';")
# ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='users';")

file = Rails.root.join("db/BakeryDataset.csv")
puts "Loading Products: #{file}"

CSV.foreach(file, headers: true) do |row|
    category = Category.find_or_create_by(name: row["category"])

    product = Product.create(
        name: row["name"],
        description: row["description"],
        price: row["price"],
        category_id: category.id
    )
end