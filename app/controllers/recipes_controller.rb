class RecipessController < ApplicationController
    def index
        @recipes = Recipe.all
    end
end