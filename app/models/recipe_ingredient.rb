class RecipeIngredient < ApplicationRecord
    # belongs_to :ingredients
    # belongs_to :recipes
    has_many :recipe_ingredients
    has_many :recipes, through: :recipe_ingredients
end
