class Cart < ApplicationRecord
  default_scope { order(created_at: :ASC) }

  scope :checkout, -> { where('status = ?', true) }
  has_many :orders
  has_many :products , through: :orders
  belongs_to :user

end
