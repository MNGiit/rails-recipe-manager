class Recipe < ApplicationRecord
    belongs_to :user
    has_many :ingredients
    has_many :reviews
    has_many :ratings, through: :reviews
    accepts_nested_attributes_for :ingredients
    validates :name, presence: { message: "Give this recipe a name!"}

    def self.by_user(user_id)
        where(user: user_id)
    end

    def username
        self.user.name
    end

    def ingredients_attributes=(ingredients_attributes)
        ingredients_attributes.values.each do |ingredient_attribute|
            if ingredient_attribute[:name] != ""
                ingredient = Ingredient.find_or_create_by(ingredient_attribute)
                self.ingredients << ingredient
            end
        end
    end
end
