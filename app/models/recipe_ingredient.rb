class RecipeIngredient < ApplicationRecord
    has_many :ingredients
    belongs_to :recipes
end
