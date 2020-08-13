class CreateProductImgs < ActiveRecord::Migration[6.0]
  def change
    create_table :product_imgs do |t|
      t.string :image, null: false
      t.references :product, foreign_key: true, null: false
      t.timestamps
    end
  end
end
