class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :name
      # t.integer :recipe_id # testing to see if it works without this line
      
      
      # t.belongs_to :recipe_ingredient

      t.timestamps
    end
  end
end
