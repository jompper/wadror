# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

bb1 = b1.beers.create name:"Iso 3", style:"Lager"
bb2 = b1.beers.create name:"Karhu", style:"Lager"
b1.beers.create name:"Tuplahumala", style:"Lager"
b2.beers.create name:"Huvila Pale Ale", style:"Pale Ale"
b2.beers.create name:"X Porter", style:"Porter"
b3.beers.create name:"Hefezeizen", style:"Weizen"
b3.beers.create name:"Helles", style:"Lager"

u1 = User.create username:"Joni", password:"Sala12", password_confirmation:"Sala12"
u2 = User.create username:"Matti", password:"1Ttam", password_confirmation:"1Ttam"

u1.ratings.create beer:bb1, score:15
u1.ratings.create beer:bb2, score:35
u2.ratings.create beer:bb1, score:25

bc1 = BeerClub.create name:"Vallilan hiiva", founded:1989,city:"Helsinki"
bc2 = BeerClub.create name:"Kumpulan akateeminen olutseura", founded:1500,city:"Helsinki"

u1.beer_clubs << bc1
u2.beer_clubs << bc1
u2.beer_clubs << bc2
