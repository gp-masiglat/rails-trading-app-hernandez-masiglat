class User < ApplicationRecord
    validates :username, :email_address, presence: true
    validates :username, :email_address, uniqueness: true
    validates :password, length: { minimum: 6 }, allow_nil: true
    has_secure_password
    has_many :cash_accounts
    has_many :stocks
    has_many :transactions


    before_validation :set_status_value
    before_validation :set_role_value

    private
        def set_status_value
            self.status = 'Pending' if status.blank?
        end

        def set_role_value
            self.role = 'Trader' if role.blank?
        end

end
