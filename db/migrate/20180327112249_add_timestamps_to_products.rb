class AddTimestampsToProducts < ActiveRecord::Migration[5.1]
  def change
        change_table(:products) { |t| t.timestamps }
    end
end
