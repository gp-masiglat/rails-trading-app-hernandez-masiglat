json.extract! transaction, :id, :user_id, :transaction_type, :stock_name, :number_of_stock, :total_price, :status, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
