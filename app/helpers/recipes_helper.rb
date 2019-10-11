module RecipesHelper
    def userid(recipe)
        recipe.user.id
    end

    def print_ingredients(recipe)
        recipe.ingredients
    end
end