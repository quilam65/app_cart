class Cart < ApplicationRecord
  default_scope { order(created_at: :ASC) }

  scope :finished, -> { where('status = ?', true) }
  scope :finished, -> { where('status = ?', true).reverse }
  has_many :orders
  has_many :products , through: :orders
  belongs_to :user

end
