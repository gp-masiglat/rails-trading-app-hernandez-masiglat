json.extract! user, :id, :username, :email_address, :password_digest, :full_name, :role, :status, :created_at, :updated_at
json.url user_url(user, format: :json)
