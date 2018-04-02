class AddPayerIdToCarts < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :payer_id, :string
  end
end
