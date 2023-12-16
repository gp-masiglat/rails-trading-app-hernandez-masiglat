class User < ApplicationRecord
    has_secure_password


    before_validation :set_status_value
    before_validation :set_role_value

    private
        def set_status_value
            self.status = 'Pending' if status.blank?
        end

        def set_role_value
            self.role = 'Trader' if status.blank?
        end

end
