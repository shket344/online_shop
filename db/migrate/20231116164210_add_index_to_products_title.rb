class AddIndexToProductsTitle < ActiveRecord::Migration[7.1]
  def change
    add_index :products, :title, unique: true
  end
end
