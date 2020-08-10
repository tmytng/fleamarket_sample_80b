class CreateDeliveryDestinations < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_destinations do |t|
      t.references :user, foreign_key: true, null: false
      t.string :family_name, null: false
      t.string :first_name, null: false
      t.string :family_name_kana, null: false
      t.string :first_name_kana, null: false
      t.integer :post_code, null: false, limit: 7
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.string :buiding_name
      t.integer :phone_number, null: false
      t.timestamps 
    end
  end
end
