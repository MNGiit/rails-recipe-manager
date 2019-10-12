class Recipe < ApplicationRecord
    belongs_to :user
    has_many :ingredients
    has_many :reviews
    has_many :ratings, through: :reviews
    accepts_nested_attributes_for :ingredients

    def self.by_user(user_id)
        where(user: user_id)
    end

    def username
        self.user.name
    end
end
