class AddReferenceProductToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :product, index: true
  end
end
