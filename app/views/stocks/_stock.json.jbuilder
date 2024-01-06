json.extract! stock, :id, :user_id, :stock_name, :price, :quantity, :created_at, :updated_at
json.url stock_url(stock, format: :json)
