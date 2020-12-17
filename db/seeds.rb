# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# main user
User.create!(
  name: 'Example User',
  email: 'exampleuser@railstutorial.org',
  password: 'foobar',
  password_confirmation: 'foobar',
  admin: true,
  activated: true
)

User.create!(
  name: 'Shane Dalton',
  email: 'shanemdalton@gmail.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true,
  activated: true
)

users = User.order(:created_at).take(6)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = 'password'
  password_confirmation = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password_confirmation,
               activated: true,
               activated_at: Time.zone.now)
  puts "creating user #{n + 1}" if (n % 5).zero?
end

50.times do |n|
  content = Faker::Hipster.sentence(word_count: 6)
  users.each { |user| user.microposts.create!(content: content) }
  puts " creating micropost batch to: #{n * 50}" if (n % 5).zero?
end


users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }