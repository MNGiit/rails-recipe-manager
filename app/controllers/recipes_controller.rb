class RecipesController < ApplicationController
    def index
        @recipes = Recipe.all
    end

    def new
        if session[:user_id]
            @recipe = Recipe.new
        else
            redirect_to login_path
        end
    end
end