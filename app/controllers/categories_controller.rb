class CategoriesController < ApplicationController
    def new
        @category = Category.new
    end
    
    def show
        @category = Category.find(params[:id])
    end

    def create
        @category = Category.new(category_params)
        if @category.valid?
            @category.save
            redirect_to @category # redirect_to user_path(@user)
        else
            render :new
        end
    end

    private

    def category_params
        params.require(:category).permit(:name)
    end
end
