class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.belongs_to :user
      t.belongs_to :recipe
      t.integer :rating
      t.timestamps
    end
  end
end
