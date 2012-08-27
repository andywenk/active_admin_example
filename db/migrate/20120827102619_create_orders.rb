class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.integer :user_id
      t.float :total

      t.timestamps
    end
  end
end
