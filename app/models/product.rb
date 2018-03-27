class Product < ApplicationRecord
  validates :title, :description,:price, presence: true
  validates :price, numericality: { greater_than: 0 }
  belongs_to :category
end
