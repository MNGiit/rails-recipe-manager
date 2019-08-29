class Recipe < ApplicationRecord
    belongs_to :user
    has_many :ingredients
    has_many :reviews
    has_many :ratings, through: reviews

    def self.by_user(user_id)
        where(user: user_id)
    end
end
