module RecipesHelper
    def username(recipe)
        recipe.user.name
    end

    def userid(recipe)
        recipe.user.id
    end

    def print_ingredients(recipe)
        recipe.ingredients
    end
end