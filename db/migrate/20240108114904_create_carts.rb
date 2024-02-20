class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :state
      t.timestamps
    end
  end
end
