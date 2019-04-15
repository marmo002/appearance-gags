# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  User.create(
    first_name: 'Martin',
    last_name: "Martin",
    email: "martin@mail.com",
    phone: "(416) 939 6469",
    password: "password",
    password_confirmation: "password"
  )
