class AddColomnToCart < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :address, :string
    add_column :carts, :name, :string
    add_column :carts, :phone, :integer
  end
end
