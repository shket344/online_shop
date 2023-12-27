class AddUserToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :user
  end
end
