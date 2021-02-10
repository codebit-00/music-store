# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

AlbumOrder.destroy_all
Order.destroy_all
Song.destroy_all
Album.destroy_all
Artist.destroy_all
Customer.destroy_all

# Create 10 artists
puts 'Start seeding artist'
10.times do 
  name = Faker::Artist.name
  nationality = Faker::Nation.nationality
  birth_date = Faker::Date.birthday(min_age: 18, max_age: 95)
  death_date = Faker::Date.between(from: Date.today, to: 50.years.from_now)
  biography = Faker::Lorem.paragraph
  artist_data = {
    name: name,
    nationality: nationality,
    birth_date: birth_date,
    death_date: death_date,
    biography: biography
  }
  Artist.find_or_create_by(artist_data)
end
puts 'Finish seeding artist'

# Create between 2 to 6 albums for each artist.
puts 'Start seeding album'
artists = Artist.all
artists.each do |artist|
  rand(2..6).times do
    name = Faker::Music.album
    price = rand(50..120)*100
    # complete songs and later complete duration for this one
    album_data = {
      name: name,
      price: price,
      artist: artist
    }
    Album.find_or_create_by(album_data)
  end
end
puts 'Finish seeding album'

# Create between 4 and 10 songs for each album.
puts 'Start seeding song'
albums = Album.all
albums.each do |album|
  rand(4..10).times do
    name = Faker::Book.title
    duration = rand(150..240)
    song_data = {
      name: name,
      duration: duration,
      album: album
    }
    Song.find_or_create_by(song_data)
  end
end
puts 'Finish seeding song'

puts 'Start update duration at albums'
albums.each do |album|
  duration = 0
  songs_duration = Song.where(album_id: album.id)
  songs_duration.each { |song| duration += song[:duration] }
  Album.where(id: album.id).update(duration: duration)
end
puts 'Finish update duration at albums'

# Create 15 customers.
puts 'Start seeding customer'
15.times do
  username = Faker::Internet.unique.username
  email = Faker::Internet.unique.email
  password = Faker::Alphanumeric.alphanumeric(number: 10)
  name = Faker::Name.name
  customer_data = {
    username: username,
    email: email,
    password: password,
    name: name
  }
  Customer.find_or_create_by(customer_data)
end
puts 'Finish seeding customer'

# Create between 1 and 5 orders for each customer.
puts 'Start seeding order'
customers = Customer.all
customers.each do |customer|
  rand(1..5).times do
    date = Faker::Date.between(from: 10.years.ago, to: Date.today)
    order_data = {
      date: date,
      total: 1,
      customer: customer
    }
    Order.find_or_create_by(order_data)
  end
end
puts 'Finish seeding order'

# Each order should include between 1 and 4 albums. And the quantity of each album in each order should be between 1 and 3.

puts 'Start seeding album_order'
orders = Order.all
orders.each do |order|
  albums_num = rand(1..4)
  albums.sample(albums_num).each do |album|
    album_order_data = {
      total_copies: rand(1..3),
      album: album,
      order: order
    }
    AlbumOrder.find_or_create_by(album_order_data)
  end
end
puts 'Finish seeding album_order'

puts 'Start update total at orders'
orders.each do |order|
  total_price = 0
  albums_by_orders = AlbumOrder.where(order_id: order.id)
  albums_by_orders.each do |album_by_order|
    albums_prices = Album.where(id: album_by_order[:album_id])
    albums_prices.each do |album_price|
      partial_price = album_by_order[:total_copies] * album_price[:price]
      total_price += partial_price
    end
  end
  Order.where(id: order.id).update(total: total_price)
end
puts 'Finish update total at orders'
