class Product < ApplicationRecord
  default_scope { order(created_at: :ASC) }

  validates :title, :description,:price, presence: true
  validates :price, numericality: { greater_than: 0 }
  belongs_to :category
end
