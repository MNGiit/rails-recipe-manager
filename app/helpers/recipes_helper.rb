module RecipesHelper
    def username(recipe)
        recipe.user.name
    end

    def userid(recipe)
        recipe.user.id
    end
end