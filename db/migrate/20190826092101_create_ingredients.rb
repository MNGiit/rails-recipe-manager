class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :recipe_id
      t.integer :recipe_ingredient

      t.timestamps
    end
  end
end
