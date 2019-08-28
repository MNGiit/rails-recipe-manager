module RecipesHelper
    def username(recipe)
        recipe.user.name
    end
end