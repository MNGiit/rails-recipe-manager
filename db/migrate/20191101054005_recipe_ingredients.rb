class RecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_ingredients do |t|
      t.belongs_to :recipe
      t.integer :quantity
      t.integer :ingredient_id
      t.string :ingredient_name

      t.timestamps
    end
  end
end
