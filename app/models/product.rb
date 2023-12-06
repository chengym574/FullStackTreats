class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, :description, :price, presence: true
  validates :price, numericality: { is_numeric: true, greater_than_or_equal_to: 0 }
end
