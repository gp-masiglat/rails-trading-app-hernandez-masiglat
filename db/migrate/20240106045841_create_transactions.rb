class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.string :transaction_type
      t.string :stock_name
      t.decimal :price
      t.integer :number_of_stock
      t.decimal :total_price
      t.string :status

      t.timestamps
    end
  end
end
