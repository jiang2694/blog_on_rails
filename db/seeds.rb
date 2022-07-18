# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Post.destroy_all

NUM_POST = 50

NUM_POST.times do
  created_at = Faker::Date.backward(days:365 * 5)

  p = Post.create(
    title: Faker::Hacker.say_something_smart,
    body: Faker::ChuckNorris.fact,
    created_at: created_at,
    updated_at: created_at,
  )
end

posts = Post.all

puts Cowsay.say("Generated #{posts.count} posts", :koala)
