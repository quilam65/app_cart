class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :express_token
      t.string :express_payer_id
      t.integer :quanlity
      t.string  :order
      t.timestamps
    end
  end
end
