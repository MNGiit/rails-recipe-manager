class RecipeIngredient < ApplicationRecord
    belongs_to :ingredients
    belongs_to :recipes
    # has_many :recipe_ingredients
    # has_many :recipes, through: :recipe_ingredients

    # testing SystemStackError: stack level too deep
    # def ingredient=(ingredient) # testing
    #     self.ingredient = ingredient
    # end
    # def ingredient # testing
    #    self.ingredient
    # end

end
