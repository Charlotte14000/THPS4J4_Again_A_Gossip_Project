# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

# Create 10 cities
10.times do
  city = City.create(name: Faker::GameOfThrones.city,
                     postal_code: Faker::Address.zip)
end

# Create 50 users
50.times do
  user = User.create(first_name: Faker::Name.first_name,
                     last_name: Faker::Name.last_name,
                     description: Faker::Lorem.sentence(12),
                     email: Faker::Internet.email,
                     age: rand(16..99),
                     city_id: rand(City.first.id..City.last.id))
end

# Create 200 gossips
200.times do
  gossip = Gossip.create(title: Faker::Book.title,
                         content: Faker::Lorem.sentence(12),
                         date: Faker::Time.between(DateTime.now, DateTime.now + 30),
                         user_id: rand(User.first.id..User.last.id))
end

# Create 10 tags
10.times do
  tag = Tag.create(title: Faker::Color.color_name)
end

# Add between 1 and 5 tags for each gossip (Each gossip has to have unless one tag)
Gossip.all.each do |gossip|
  rand(1..5).times do
    GossipTag.create(gossip_id: gossip.id,
                     tag_id: rand(Tag.first.id..Tag.last.id))
                     # TODO : find a way to avoid several times the same tag in a gossip !
  end
end

# Create 10 PMs
10.times do
    pm = PrivateMessage.create(content: Faker::Lorem.sentence(8),
                               date: Faker::Time.between(DateTime.now, DateTime.now + 30),
                               sender_id: rand(User.first.id..User.last.id))
end

# For each PM, add between 1 and 5 recipients
PrivateMessage.all.each do |pm|
  rand(1..5).times do
    PrivateMessageRecipient.create(private_message_id: pm,
                                   recipient_id: rand(User.first.id..User.last.id))
                                   # TODO : find a way to avoid several times the same recipient in a PM !
  end
end

# Add 50 comments
50.times do
  # Select the comment's support
  commentable_types = [Comment, Gossip]
  commentable_type = commentable_types[rand(0..1)]

  # Set the range of the rand according to the comment's support
  if commentable_type == Comment && Comment.last != nil
    commentable_id = rand(Comment.first.id..Comment.last.id)
  elsif commentable_type == Gossip
    commentable_id = rand(Gossip.first.id..Gossip.last.id)
  else
    redo # If no comments, we can't comment a comment => Try again
  end

  comment = Comment.create(content: Faker::Lorem.sentence(8),
                           user_id: rand(User.first.id..User.last.id),
                           commentable_id: commentable_id,
                           commentable_type: commentable_type)
end

# Add 100 likes
100.times do
  # Select the like's support
  likeable_types = [Comment, Gossip]
  likeable_type = likeable_types[rand(0..1)]

  # Set the range of the rand according to the like's support
  if likeable_type == Comment && Comment.last != nil
    likeable_id = rand(Comment.first.id..Comment.last.id)
  elsif likeable_type == Gossip
    likeable_id = rand(Gossip.first.id..Gossip.last.id)
  else
    redo # If no comments, we can't like a comment => Try again
  end

  like = Like.create(user_id: rand(User.first.id..User.last.id),
                     likeable_id: likeable_id,
                     likeable_type: likeable_type)
end
