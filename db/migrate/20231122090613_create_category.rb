class CreateCategory < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
