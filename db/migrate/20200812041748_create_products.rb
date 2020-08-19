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
      t.references :category, foreign_key: true, null: false
      t.references :brand, foreign_key: true
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
