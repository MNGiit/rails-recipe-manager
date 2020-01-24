class Recipe < ApplicationRecord
    belongs_to :user
    belongs_to :category
    # has_many :ingredients # testing out recipe_ingredients
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients
    has_many :reviews
    has_many :ratings, through: :reviews
    # accepts_nested_attributes_for :ingredients # testing out recipe_ingredients
    accepts_nested_attributes_for :recipe_ingredients
    validates :name, presence: { message: "Give this recipe a name!"}
    scope :order_by_abc, -> { order('name ASC') }
    # scope :red, -> { where(color: 'red') }
    # @recipes = @user.recipes.order('name ASC')
    # @recipes = Recipe.order('name ASC')

    def username
        self.user.name
    end

    def ingredients_attributes=(ingredients_attributes)
        ingredients_attributes.values.each do |ingredient_attribute|
            if ingredient_attribute[:name] != ""
                ingredient = Ingredient.find_or_create_by(ingredient_attribute)
                self.ingredients << ingredient
            end
        end
    end

    def recipe_ingredients_attributes=(recipe_ingredients_attributes)
        recipe_ingredients_attributes.values.each do |recipe_ingredient_attributes|
            # self.recipe_ingredients << recipe_ingredient_attributes


            # recipe_ingredient_attributes[:ingredient]
            # recipe_ingredient_attributes[:ingredient][:name]
            if recipe_ingredient_attributes[:ingredient][:name] != ""
                ingredient = Ingredient.find_or_create_by(name: recipe_ingredient_attributes[:ingredient][:name])
                recipe_ingredient = RecipeIngredient.new
                recipe_ingredient.quantity = recipe_ingredient_attributes[:quantity] if recipe_ingredient_attributes[:quantity] != ""
                ingredient.recipe_ingredients << recipe_ingredient
                # ingredient = Ingredient.find_or_create_by(name: recipe_ingredient_attributes[:ingredient_id])
                # recipe_ingredient = RecipeIngredient.new
                # recipe_ingredient.quantity = recipe_ingredient_attributes[:quantity] if recipe_ingredient_attributes[:quantity] != ""
                # some reason .save or .find_or_create doesn't actually save ingredient, so I keep getting nil value
                # ingredient.errors shows me these errors
                # @base=#<Ingredient:0xb39e27cc id: nil, name: "Cheese", recipe_id: nil, created_at: nil, updated_at: nil>,
                # @details={:recipes=>[{:error=>:blank}], :recipe_ingredients=>[{:error=>:blank}]},
                # @messages={:recipes=>["must exist"], :recipe_ingredients=>["must exist"]}>
                # first i might have to save recipe earlier even though it was working before in the old way
                # second i'll have recipe_ingredient get saved first and then ingredient
                # self.save # might save it at the controller so it doesn't get repeated a lot, or before .each
                # problem seems to be Ingredient.rb and using belongs_to when it shoudl be has_many through
                

                # recipe_ingredient.ingredient_id = ingredient.id # it seems if ingredient isn't saved, i don't have to use . or dotingredient_id and can just use ingredient
                # recipe_ingredient.ingredient = ingredient
                # apply recipe_id if needed. might have to first "save" recipe and then use self.id
                # apply quantity too
                # recipe_ingredient.ingredient_id = ingredient works in pry but not in real time?!?!?!
                # recipe_ingredient.ingredient.id = ingredient # recipe_ingredient.ingredient = ingredient doesn't work, produes error
                # binding.pry
                self.recipe_ingredients << recipe_ingredient
            end
        end
    end
end
