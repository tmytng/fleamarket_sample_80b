class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :price
      t.string :description
      t.string :condition
      t.string :size
      t.string :shipping_cost
      t.string :shipping_days
      t.string :prefecture
      t.string :trading_status
      t.integer :category_id
      t.integer :brand_id
      t.integer user_id
      t.timestamps
    end
  end
end
