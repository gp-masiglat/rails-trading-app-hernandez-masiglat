class CreateStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.integer :user_id
      t.string :symbol
      t.integer :quantity

      t.timestamps
    end
  end
end
