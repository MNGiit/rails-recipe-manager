class Category < ApplicationRecord
    has_many :recipes

    validates :name, presence: { message: "Give this category a name!"}
end
