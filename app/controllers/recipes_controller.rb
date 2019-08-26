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
        params[:recipe].merge!(user_id: params[:user_id])
        binding.pry
        redirect_to recipes_path
    end
end