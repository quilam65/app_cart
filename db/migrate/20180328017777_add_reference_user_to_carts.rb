class AddReferenceUserToCarts < ActiveRecord::Migration[5.1]
  def change
    add_reference :carts, :user, index: true
  end
end
