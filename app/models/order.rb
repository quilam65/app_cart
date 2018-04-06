class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :quanlity, presence: true
  validates :quanlity, numericality: { greater_than: 0 }

  def self.find_order(product_id, cart_id)
    return Order.where('product_id = ? AND cart_id = ?',product_id, cart_id).limit(1).first
  end

end
