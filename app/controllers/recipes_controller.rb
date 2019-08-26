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
        binding.pry
        redirect_to recipes_path
    end

    private

    def recipe_params
        params.require(:recipe).permit(:name, :user_id)
    end
end