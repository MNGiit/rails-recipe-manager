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
        end
    end
end
