class AddFinishedToCarts < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :finished, :boolean, :default => false
  end
end
