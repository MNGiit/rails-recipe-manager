class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.belongs_to :user
      t.belongs_to :recipe

      t.integer :score # score should be it's own attribute, not a model
      t.timestamps
    end
  end
end
