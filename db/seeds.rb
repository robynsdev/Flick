# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# if Movie.all.length == 0
#   3.times {
#     movie_title = Faker::Movie.title
#     movie_release_date = Faker::Date.between(from: '2014-09-23', to: Date.today)
#     movie_description = Faker::Movie.quote
#     movie_genre = Faker::Book.genre
#     movie_run_time = rand(60..360)

#     Movie.create(title: movie_title, release_date: movie_release_date, description: movie_description, genre: movie_genre, run_time: movie_run_time)

#     puts "Created Movie: #{movie_title}."
#   }
# end

if User.count == 0
  User.create(username: "pikachu", email: "pikachu@test.com", password: "password1", password_confirmation: "password1")
  User.create(username: "charmander", email: "char@test.com", password: "password2", password_confirmation: "password2")
  User.create(username: "squirtle", email: "squirtle@test.com", password: "password3", password_confirmation: "password3")

  puts "Created Users."
end

if Watchlist.all.length == 0
  6.times {
    user_id = rand(1..3)
    movie_id = rand(60..360)
    title = Faker::Movie.title

    Watchlist.create(user_id: user_id, movie_id: movie_id, title: title)

    puts "Created Movie in Watchlist: #{title}, #{user_id}."
  }
end


