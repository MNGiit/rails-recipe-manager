module UsersHelper
    def recipes_count(user)
        @user.recipes.count
    end
end
