class Recipe < ApplicationRecord
    belongs_to :user
    has_many :ingredients

    def self.by_user(user_id)
        where(user: user_id)
    end
end
