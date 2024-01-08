class CashAccount < ApplicationRecord
    validates :bank_name, presence: true
    validates :user_id, presence: true
    validates :amount, presence: true
    belongs_to :user
end
