class Ingredient < ApplicationRecord
   # belongs_to :recipes, optional: true
   belongs_to :recipes
   belongs_to :recipe_ingredients
end
