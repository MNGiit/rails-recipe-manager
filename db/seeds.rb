# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
bob = User.create(name: 'Bob', email: 'bob@gmail.com', password: 'password')
chris = User.create(name: 'Chris', email: 'chris@gmail.com', password: 'password')
jill = User.create(name: 'Jill', email: 'jill@gmail.com', password: 'password')
brian = User.create(name: 'Brian', email: 'brian@gmail.com', password: 'password')
rebecca = User.create(name: 'Rebecca', email: 'rebecca@gmail.com', password: 'password')
cindy = User.create(name: 'Cindy', email: 'cindy@gmail.com', password: 'password')

water = Ingredient.create(name: "Water")
orange = Ingredient.create(name: "Orange")

# oj = Recipe.create(name: "Orange Juice", user: bob, ingredients: [water, orange])

pbj = Recipe.create(name: 'PBJ Sandwich', user_id: bob.id)
egg_sandwich = Recipe.create(name: 'Egg sandwich', user_id: bob.id)
cup_ramen = Recipe.create(name: 'Cup Ramen', user_id: bob.id)
pineapple_pizza = Recipe.create(name: 'Pineapple Pizza', user_id: bob.id)
chocolate_milk = Recipe.create(name: 'Chocolate Milk', user_id: chris.id)
milk_tea = Recipe.create(name: 'Milk Tea', user_id: chris.id)
french_fries = Recipe.create(name: 'French Fries', user_id: jill.id)
hamburger = Recipe.create(name: 'Hamburger', user_id: jill.id)
turkey_burger = Recipe.create(name: 'Turkey Burger', user_id: jill.id)
pea_soup = Recipe.create(name: 'Pea Soup', user_id: jill.id)

breakfast = Category.create(name: 'Breakfast')
lunch = Category.create(name: 'Lunch')
dinner = Category.create(name: 'Dinner')