class ReviewsController < ApplicationController
    def index
    end

    def show
        whereami = "in #show"
        # binding.pry
    end

    def new
        whereami = "in #new"
        # binding.pry
    end

    def create
        whereami = "in #create"
        # get recipe first
        @recipe = Recipe.find_by(id: review_params[:recipe_id])
        # check if recipe already has a review by this user
        @review = Review.find_or_create_by(user_id: session[:user_id], recipe_id: @recipe.id)
        @review.score = review_params[:score]
        @review.save
        redirect_to recipe_path(@recipe)
    end

    def edit
    end

    def update
        whereami = "in #update"
        # took out code because #create can do it
    end
    
    private

    def review_params
        params.require(:review).permit(:score, :recipe_id)
    end
end
