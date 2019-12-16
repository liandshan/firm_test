class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id,index: true
      t.integer :product_id, index: true
      t.integer :num
      t.string :batch_id

      t.timestamps
    end
  end
end
