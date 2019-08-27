class RecipesController < ApplicationController
    def index
        @recipes = Recipe.all
    end

    def new
        if session[:user_id]
            if session[:user_id] == params[:user_id].to_i
                @recipe = Recipe.new
            else
                redirect_to "/users/#{session[:user_id]}"
            end
        else
            redirect_to login_path
        end
    end

    def create
        params[:recipe].merge!(user_id: params[:user_id]) # .merge helps add :user_id to params[:recipe]
        params[:recipe].merge!(ingredients: params[:ingredients])
        params[:recipe].permit! # can't get ingredient_params to work, but this works
        # ings = params[:recipe][:ingredients]
        ings = params[:recipe][:ingredients].collect do |ing|
            Ingredient.new(name: ing[:name])
        end
        recipe = Recipe.new(recipe_params)
        recipe.ingredients = ings
        recipe.save
        binding.pry
        redirect_to recipes_path
    end

    private

    def recipe_params
        params.require(:recipe).permit(:name, :user_id)
    end

    def ingredients_params
        params.require(:ingredients).permit(:name) # doesn't work
    end
end