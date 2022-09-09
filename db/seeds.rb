# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "json"
require "open-uri"
require "nokogiri"
require 'faker'

Review.delete_all
Recipe.delete_all
User.delete_all
Community.delete_all
User.delete_all


filepath = 'db/recipes.json'

serialized_data = File.read(filepath)

recipes = JSON.parse(serialized_data)

puts "Creating admin user"

count = 0
user1 = User.new(fullname: "Admin", email: "admin@ingredible.me", admin:  true, password: "test1234")
user1.save!

puts "Admin user created"

puts "Creating Recipes"

# RECIPES CREATION

recipes.slice!(0, 30).each do |recipe|
  new_recipe = Recipe.new(name: recipe["Name"],
    ingredients: recipe["Ingredients"].join(", "),
    difficulty: ['easy', 'medium', 'hard'].sample,
    time: (1..10).to_a.sample,
    steps: recipe["Method"].join('--'),
    serves: 2,
    category: "To be confirmed",
    user: user1
  )
  url = recipe["url"]
  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML(html_file)
  html_doc.search(".post-header__image-container .image__img").each do |element|
    element.text.strip
    file = URI.open(element.attribute("src").value)
    new_recipe.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  end

  puts "adding the cooking time"
  html_doc.search('span').each do |element|
    if element.text === "Cook:"
      new_recipe.time = element.next_element.text
    end
  end
  puts "finished with the cooking time"

  new_recipe.save!
  count += 1
  puts count
end

puts "finished with the recipes"

# COMMUNITIES CREATION

filepath_communities = 'db/communities.json'

serialized_data_community = File.read(filepath_communities)

communities = JSON.parse(serialized_data_community)

communities.each do |community|
  new_community = Community.new(name: community["name"], description: community["description"])
  community_file = URI.open(community["img"])
  new_community.photo.attach(io: community_file, filename: 'nes.png', content_type: 'image/png')
  new_community.save!
end

# USERS CREATION

10.times do
  user = User.new(fullname: Faker::Name.name, password: "test1234")
  user.email = "#{user.fullname.split(' ').join('')}@test.com"
  user.save!
 end

#  REVIEWS CREATION


puts "adding the reviews"

filepath_reviews = 'db/reviews.json'

serialized_data_reviews = File.read(filepath_reviews)

reviews = JSON.parse(serialized_data_reviews)

reviews.each do |review|
  new_review = Review.new(content: review["review"], rating: (1..5).to_a.sample, user: User.order("RANDOM()").first, recipe:Recipe.order("RANDOM()").first)
  new_review.save!
end

puts "finish with the reviews"
