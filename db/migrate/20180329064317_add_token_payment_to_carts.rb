class AddTokenPaymentToCarts < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :token_payment, :string
  end
end
