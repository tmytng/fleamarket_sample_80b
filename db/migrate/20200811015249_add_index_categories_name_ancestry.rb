class AddIndexCategoriesNameAncestry < ActiveRecord::Migration[6.0]
  def change
    add_index :categories, [:name, :ancestry]
  end
end
