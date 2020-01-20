module RecipesHelper
    def userid(recipe)
        recipe.user.id
    end

    def print_ingredients(recipe)
        # recipe.ingredients # changed association so this no longer works
        recipe.recipe_ingredients
    end
end