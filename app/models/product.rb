class Product < ApplicationRecord
  default_scope { order(created_at: :DESC) }

  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  belongs_to :category
  has_many :orders
  has_many :carts, :through => :orders
end
