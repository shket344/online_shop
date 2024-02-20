class AddQuantityToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :quantity, :integer, default: 0
  end
end
