class User < ApplicationRecord
    has_secure_password
    has_many :recipes
    has_many :reviews
    validates :email, uniqueness: { message: "Email in use!" }
    validates :name, presence: { message: "You forgot to give your name."}
    # there seems to be a validate password already built in, so maybe I don't have to check for presence
end
