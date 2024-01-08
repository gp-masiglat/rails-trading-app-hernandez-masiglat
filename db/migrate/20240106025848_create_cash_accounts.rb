class CreateCashAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :cash_accounts do |t|
      t.string :bank_name
      t.string :account_number
      t.decimal :amount
      t.string :trans_type
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
