require 'pry'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(username:"sarah",password:"password",password_confirmation:"password",email:"sarah@gmail.com")
spot = user.spots.create(name:"Sarah's Bakery",
				  address:"100 Fifth Avenue New York, NY 10003",
				   phone:"212-555-555", price: 2)
Favorite.create(user: user, spot: spot)
Comment.create(user: user, spot: spot, body:"Best cookies ever!")

response = Yelp.client.search('New York City', category_filter: 'breakfast_brunch')
response.businesses.each do |biz|
  Spot.create(name: biz.name, address: biz.location.display_address.join(", "), phone: biz.phone, website: biz.url, photo: biz.image_url.gsub!(/ms.jpg/, 'l.jpg'))
end
user_no_fave = User.create(username:"nicolle", password:"test", password_confirmation:"test", email:"nicolle@gmail.com")