class AddReferenceCartToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :cart, index: true
  end
end
