class RecipesController < ApplicationController
    def index
        if params[:user_id]
            @user = User.find(params[:user_id])
            @recipes = Recipe.by_user(params[:user_id])
        else
            @recipes = Recipe.all
        end
    end

    def new
        if session[:user_id]
            if session[:user_id] == params[:user_id].to_i
                @recipe = Recipe.new
                5.times {@recipe.ingredients << Ingredient.new}
            else
                redirect_to "/users/#{session[:user_id]}"
            end
        else
            redirect_to login_path
        end
    end

    def create
        params[:recipe].merge!(user_id: params[:user_id]) # .merge helps add :user_id to params[:recipe]

        # the 'too many lines of code' way
        # params[:recipe].merge!(ingredients: params[:ingredients])
        # params[:recipe].permit! # can't get ingredient_params to work, but this works

        # ings = params[:recipe][:ingredients]

        # use .compact to get rid of nil values
        # arr = params[:recipe][:ingredients].collect do |ing|
        #    if ing[:name] != ""
        #        ing
        #    end
        # end.compact # use .compact to get rid of nil values

        # ings = arr.map do |ing|
        #    Ingredient.find_or_create_by(name: ing[:name])
        # end
        @recipe = Recipe.new(recipe_params)
        # @recipe.ingredients_attributes = recipe_params[:ingredients_attributes] # don't need to do this because Recipe.new can do it...this will double ingredients
        @recipe.save
        redirect_to @recipe
    end

    def show
        @recipe = Recipe.find(params[:id])
    end
    
    def edit
        # this is what params looks like
        # {"controller"=>"recipes", "action"=>"edit", "user_id"=>"6", "id"=>"25"}
        # redirect_to "/users/#{session[:user_id]}/recipes/#{params[:user_id]}/edit"
        if session[:user_id]
            if session[:user_id] == params[:user_id].to_i
                @recipe = Recipe.find(params[:id])
            else
                redirect_to "/users/#{session[:user_id]}"
            end
        else
            redirect_to login_path
        end     
    end

    def update
        params[:recipe].merge!(user_id: params[:user_id]).merge!(ingredients: params[:ingredients]) # .merge helps add :user_id to params[:recipe]
        # params[:recipe].merge!(ingredients: params[:ingredients])
        # params[:recipe].permit! can be avoided, look at recipe_params. but this leads to Ingredient.new problem
        params[:recipe].permit! # can't get ingredient_params to work, but this works
        arr = params[:recipe][:ingredients].collect { |i| i if i[:name] != "" }.compact

        ings = arr.map do |ing|
            Ingredient.find_or_create_by(name: ing[:name])
        end

        @recipe = Recipe.find(params[:id])
        @recipe.ingredients = ings
        @recipe.update(recipe_params)
        # binding.pry
    
        redirect_to @recipe
    end

    def destroy
        recipe = Recipe.find(params[:id])
        if session[:user_id] == recipe.user.id
            Recipe.find(params[:id]).destroy
            redirect_to recipes_path
        end
        # Recipe.find(params[:id]).destroy
        # redirect_to recipes_path
    end

    private

    def recipe_params
        # params.require(:recipe).permit(:name, :user_id, { ingredients: :name}) # this works but ingredients causes problems when doing Ingredient.new(recipe_params)

        # testing out new code. line below works
        # params.require(:recipe).permit(:name, :user_id) # this works
        params.require(:recipe).permit(:name, :user_id, ingredients_attributes: [:name]) # can also be ingredients_attributes: :name
    end

    def ingredients_params
        params.require(:ingredients).permit(:name) # doesn't work
    end
end