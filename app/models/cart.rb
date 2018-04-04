class Cart < ApplicationRecord
  default_scope { order(finished: :DESC,created_at: :DESC) }

  has_many :orders
  has_many :products , through: :orders
  belongs_to :user

end
