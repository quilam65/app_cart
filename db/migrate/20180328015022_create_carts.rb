class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.integer :total_amount_cents

      t.timestamps
    end
  end
end
