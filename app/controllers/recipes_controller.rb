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
        # params[:recipe].permit! can be avoided, look at recipe_params. but this leads to Ingredient.new problem
        params[:recipe].permit! # can't get ingredient_params to work, but this works

        # ings = params[:recipe][:ingredients]

        # old way where it doesn't get rid of nil values..it works but i want the nil values gone
        # ings = params[:recipe][:ingredients].collect do |ing|
        #     Ingredient.find_or_create_by(name: ing[:name])
        # end

        # use .compact to get rid of nil values
        arr = params[:recipe][:ingredients].collect do |ing|
            if ing[:name] != ""
                ing
            end
        end.compact # use .compact to get rid of nil values

        ings = arr.map do |ing|
            Ingredient.find_or_create_by(name: ing[:name])
        end

        binding.pry

        @recipe = Recipe.new(recipe_params)
        @recipe.ingredients = ings
        @recipe.save
    
        redirect_to @recipe
    end

    def show
        @recipe = Recipe.find(params[:id])
    end

    private

    def recipe_params
        # params.require(:recipe).permit(:name, :user_id, { ingredients: :name}) # this works but ingredients causes problems when doing Ingredient.new(recipe_params)
        params.require(:recipe).permit(:name, :user_id)
    end

    def ingredients_params
        params.require(:ingredients).permit(:name) # doesn't work
    end
end