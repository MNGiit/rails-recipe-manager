class RecipeIngredient < ApplicationRecord
    belongs_to :ingredient, optional: true # fix it
    belongs_to :recipe, optional: true # fix it
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
