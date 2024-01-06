class CashAccount < ApplicationRecord
    validates :username, presence: true, uniqueness: { scope: :email_address }
end
