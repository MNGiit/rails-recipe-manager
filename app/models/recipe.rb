class Recipe < ApplicationRecord
    belongs_to :user
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
            if recipe_ingredient_attributes[:ingredient_id] != ""
                ingredient = Ingredient.find_or_create_by(name: recipe_ingredient_attributes[:ingredient_id])
                recipe_ingredient = RecipeIngredient.new
                recipe_ingredient.quantity = recipe_ingredient_attributes[:quantity] if recipe_ingredient_attributes[:quantity] != ""
                recipe_ingredient.ingredient_id = ingredient.id
                binding.pry
                # apply recipe_id if needed. might have to first "save" recipe and then use self.id
                # apply quantity too
                # recipe_ingredient.ingredient_id = ingredient works in pry but not in real time?!?!?!
                # recipe_ingredient.ingredient.id = ingredient # recipe_ingredient.ingredient = ingredient doesn't work, produes error
                self.recipe_ingredients << recipe_ingredient
            end
        end
    end
end
