class RecipesController < ApplicationController
    def index
        @recipes = Recipe.all
    end

    def new
        binding.pry
        if session[:user_id]
            if session[:user_id] == params[:user_id]
                @recipe = Recipe.new
            else
                redirect_to "/users/#{session[:user_id]}"
            end
        else
            redirect_to login_path
        end
    end
end