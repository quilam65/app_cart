class Cart < ApplicationRecord
  has_many :orders
  has_many :products , through: :orders
  belongs_to :user

  def get_cart
    if current_user.carts.where(status: false).present?
  end
end
