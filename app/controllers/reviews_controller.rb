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
        binding.pry
    end

    def edit
    end

    def update
    end
    
    private

    def review_params
        params.require(:review).permit(:score)
    end
end
