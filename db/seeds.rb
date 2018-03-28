# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.destroy_all
Product.destroy_all
Cart.destroy_all
Order.destroy_all
c = Category.create(title:'Smart Phone')
Product.create(title: 'Nokia 8', price: 499, description: 'smart phone', category_id: c.id)
Product.create(title: 'Nokia 9', price: 499, description: 'smart phone', category_id: c.id)
Product.create(title: 'Nokia 10', price: 499, description: 'smart phone', category_id: c.id)
