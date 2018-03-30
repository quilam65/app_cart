class AddPaymentIdToCarts < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :payment_id, :string
  end
end
