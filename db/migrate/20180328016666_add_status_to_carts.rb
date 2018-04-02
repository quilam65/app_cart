class AddStatusToCarts < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :status, :boolean
  end
end
