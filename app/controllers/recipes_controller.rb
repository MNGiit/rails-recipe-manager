class RecipesController < ApplicationController
    def index
        # scope method applied and assigned to @recipes. puts recipes in alphabetical order
        if params[:user_id]
            @user = User.find(params[:user_id])
            # @recipes = @user.recipes.order('name ASC') # scope :order_by_abc
            @recipes = @user.recipes.order_by_abc
        else
            # @recipes = Recipe.order('name ASC') # scope :order_by_abc
            @recipes = Recipe.order_by_abc
        end
    end

    def new
        if session[:user_id]
            if session[:user_id] == params[:user_id].to_i
                @recipe = Recipe.new
                # 5.times {@recipe.recipe_ingredients << RecipeIngredient.new}

                # 5.times do
                #     recipe_ingredient = @recipe.recipe_ingredients.build
                #     recipe_ingredient.build_ingredient
                # end

                5.times do
                    @recipe.recipe_ingredients.build
                end

                # don't seem to need to build_ingredient but will keep here just in case
                # @recipe.recipe_ingredients.each do |r_ing|
                #     r_ing.build_ingredient
                # end

                # array.each {|item| puts "The current array item is: #{item}"}
                # testRecipeIngredient.ingredients << testIngredient doesn't work
                # testRecipeIngredient.ingredient_id = testIngredient.id works but trying it below doesn't work
                # 5.times {@recipe.recipe_ingredients.ingredient_id << Ingredient.new.id}
                # 5.times {@recipe.recipe_ingredients.ingredients << Ingredient.new}
                
                # @ingredients = 5.times.map {Ingredient.new} # testing out above line
                # @ingredients.each do |ing|
                #     ing.recipe_ingredients.build
                # end
                # @recipe_ingredients = 5.times.map {RecipeIngredient.new}


                # 5.times {@recipe.ingredients << Ingredient.new}
                # later test out line below to see if it's needed by commenting it out

                # @recipe.recipe_ingredients.each {|item| item.ingredient_id = Ingredient.new.id} # if this doesn't work try creating @ingredients then use loop
            else
                redirect_to "/users/#{session[:user_id]}"
            end
        else
            redirect_to login_path
        end
    end

    def create
        params[:recipe].merge!(user_id: params[:user_id]) # .merge helps add :user_id to params[:recipe]
        # params[:recipe][:recipe_ingredients_attributes].values
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


        # params[:recipe][:recipe_ingredients_attributes] ### this line shows important params
        # params[:recipe][:recipe_ingredients_attributes][:"0"] ### this line shows this...
        # <ActionController::Parameters {"ingredient"=>{"name"=>"Carrot"}, "quantity"=>"1"} permitted: false>
        # can only permit it with this line so far: params[:recipe][:recipe_ingredients_attributes][:"0"][:ingredient].permit!
        # can also seem to permit like this: params.require(:recipe).permit( recipe_ingredients_attributes: [ingredient: :name] )
        @recipe = Recipe.new(recipe_params)
        # @recipe.ingredients_attributes = recipe_params[:ingredients_attributes] # don't need to do this because Recipe.new can do it...this will double ingredients
        if @recipe.valid?
            @recipe.save
            redirect_to @recipe # redirect_to user_path(@user)
        else
            # render new_user_recipe_path
            # 5.times {@recipe.ingredients << Ingredient.new} # old way
            # new way
            5.times {@recipe.recipe_ingredients << RecipeIngredient.new} # might not need this
            render :new
        end
        # @recipe.save
        # redirect_to @recipe
    end

    def show
        @recipe = Recipe.find(params[:id])
        if session[:user_id] && @recipe.user_id != session[:user_id]
            user_review = @recipe.reviews.find_by(user_id: session[:user_id])
            if user_review != nil
                @review = user_review
            else
                @review = Review.new(user_id: session[:user_id])
            end
        end
        # if recipe isn't by current user
        #   find review by user using session[:user_id]
        #   user_review = @recipe.reviews.find_by(user_id: session[:user_id])
        #   if user_review NOT EMPTY
        #        @review = user_review
        #   else
        #       @review = Review.new(user_id: session[:user_id])
        #   end
        #   @review = Review.new(user_id: session[:user_id]) if user_review NOT empty
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

        # testing out new code
        # params.require(:recipe).permit(:name, :user_id, ingredients_attributes: [:name]) # can also be ingredients_attributes: :name # PREVIOUS WORKING CODE
        # params.require(:recipe).permit(:name, :user_id, recipe_ingredients_attributes: [:name, :quantity]) # new code ## testing newer code
        params.require(:recipe).permit(:name, :user_id, recipe_ingredients_attributes: [[ingredient: :name], :quantity])
    end
end