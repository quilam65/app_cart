class Cart < ApplicationRecord
  default_scope { where(status: true).order(created_at: :asc) }
  has_many :orders
  has_many :products , through: :orders
  belongs_to :user

end
