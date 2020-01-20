class Ingredient < ApplicationRecord
   # belongs_to :recipes, optional: true
   # belongs_to :recipes
   # belongs_to :recipe_ingredients
   has_many :recipe_ingredients
   has_many :recipes, through: :recipe_ingredients
end
