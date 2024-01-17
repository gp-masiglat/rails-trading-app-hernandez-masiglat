class Stock < ApplicationRecord
    # validates :symbol, presence: true, uniqueness: true
    belongs_to :user
end
