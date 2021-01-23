# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

if Movie.all.length == 0
  3.times {
    movie_title = Faker::Movie.title
    movie_release_date = Faker::Date.between(from: '2014-09-23', to: Date.today)
    movie_description = Faker::Movie.quote
    movie_genre = Faker::Book.genre
    movie_run_time = rand(60..360)

    Movie.create(title: movie_title, release_date: movie_release_date, description: movie_description, genre: movie_genre, run_time: movie_run_time)

    puts "Created Movie: #{movie_title}."
  }
end