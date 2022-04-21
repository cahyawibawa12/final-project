class CreateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :order_details do |t|
      t.float :price
      t.integer :qty
      t.float :sub_total

      t.timestamps
    end
  end
end
