class Cart < ApplicationRecord
  default_scope { order(finished: :ASC ,created_at: :DESC) }

  has_many :orders
  has_many :products , through: :orders
  belongs_to :user

  paginates_per 5
end
