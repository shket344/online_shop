class AddCategoryToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :category, null: false
  end
end
