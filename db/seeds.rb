# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
b1 = Brewery.create name: "Koff", year: 1897
b2 = Brewery.create name: "Malmgard", year: 2001
b3 = Brewery.create name: "Weihenstephaner", year: 1040

s1 = Style.create name: "Weizen"
s2 = Style.create name: "Lager"
s3 = Style.create name: "Pale ale"
s4 = Style.create name: "IPA"
s5 = Style.create name: "Porter"
s6 = Style.create name: "Lowalcohol"

b1.beers.create name: "Iso 3", style: s2
b1.beers.create name: "Karhu", style: s2
b1.beers.create name: "Tuplahumala", style: s2
b2.beers.create name: "Huvila Pale Ale", style: s3
b2.beers.create name: "X Porter", style: s5
b3.beers.create name: "Hefeweizen", style: s1
b3.beers.create name: "Helles", style: s2
