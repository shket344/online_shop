class AddFundToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :fund, :decimal, default: 0.0, precision: 8, scale: 2
  end
end
