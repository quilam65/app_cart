class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  scope :finished_cart, -> { joins(:cart).where('carts.status = true') } 
end
