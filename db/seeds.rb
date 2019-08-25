# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
bob = User.create(name: 'Bob', email: 'bob@gmail.com')
pbj = Recipe.create(name: 'PBJ Sandwich')
egg_sandwich = Recipe.create(name: 'Egg sandwich')
cup_ramen = Recipe.create(name: 'Cup Ramen')
pineapple_pizza = Recipe.create(name: 'Pineapple Pizza')
chocolate_milk = Recipe.create(name: 'Chocolate Milk')
milk_tea = Recipe.create(name: 'Milk Tea')
french_fries = Recipe.create(name: 'French Fries')
hamburger = Recipe.create(name: 'Hamburger')
turkey_burger = Recipe.create(name: 'Turkey Burger')
pea_soup = Recipe.create(name: 'Pea Soup')