class AddCartToOrders < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :cart
  end
end
