json.extract! cash_account, :id, :bank_name, :amount, :account_number, :user_id, :trans_type, :status, :created_at, :updated_at
json.url cash_account_url(cash_account, format: :json)