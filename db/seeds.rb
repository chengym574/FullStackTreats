require 'faker'

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

# Create 4 categories
categories = 4.times.map do
    Category.create(name: Faker::Food.ethnic_category)
end

# Create 100 products associated with the categories
100.times do
    category = categories.sample
    category.products.create(
      name: Faker::Food.dish,
      description: Faker::Food.description,
      price: Faker::Commerce.price(range: 5.0..100.0),
    )
  end