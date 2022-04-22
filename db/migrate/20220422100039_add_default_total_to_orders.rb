class AddDefaultTotalToOrders < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :total, :float, :default => 0.0
  end
end
