class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :price
      t.string :description
      t.integer :condition, null: false
      t.string :size
      t.integer :shipping_cost, null: false
      t.integer :shipping_days, null: false
      t.string :prefecture
      t.string :trading_status
      t.references :category, foreign_key: true, null: false
      t.references :brand, foreign_key: true
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
