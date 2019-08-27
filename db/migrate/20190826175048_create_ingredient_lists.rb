class CreateIngredientLists < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredient_lists do |t|
      t.string :name

    # how to create table with one of the attributes being an array
    # this is for ingredients, because a recipe has more than 1 ingredient
    # https://stackoverflow.com/questions/32409820/add-an-array-column-in-rails
    #  create_table :products do |t|
    #    t.string :name, null: false
    #    t.references :category, null: false
    #    t.text :tags, array: true, default: []
    #  end

      t.timestamps
    end
  end
end
