class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :quanlity, presence: true
  validates :quanlity, numericality: { greater_than: 0 }
end
