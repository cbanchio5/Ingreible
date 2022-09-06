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

Recipe.delete_all
User.delete_all
Community.delete_all
User.delete_all

filepath = 'db/recipes.json'

serialized_data = File.read(filepath)

recipes = JSON.parse(serialized_data)

count = 0
user1 = User.new(fullname: "Admin", email: "admin@ingredible.me", admin:  true, password: "test1234")
user1.save!

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
  html_doc.search('span').each do |element|
    if element.text === "Cook:"
      new_recipe.time = element.next_element.text
    end

  end


  new_recipe.save!
  count += 1
  puts count
end

filepath_communities = 'db/communities.json'

serialized_data_community = File.read(filepath_communities)

communities = JSON.parse(serialized_data_community)

communities.each do |community|
  new_community = Community.new(name: community["name"], description: community["description"])
  new_community.save!
end

10.times do
 user = User.new(fullname: Faker::Name.name, password: "test1234")
 user.email = "#{user.fullname.split(' ').join('')}@test.com"
 user.save!
end
