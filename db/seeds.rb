# ruby encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Team.create(name: "Chaos", colour: "FF0000")
Team.create(name: "Sajberkomm", colour: "003CFF")
Team.create(name: "Klustret", colour: "B300FF")
Team.create(name: "Hjortkloe", colour: "FFBF00")
empty = Team.create(name: "ownerless", colour: "000000")


Station.create(location: "Sinter Plant", team: empty)
Station.create(location: "Desert", team: empty)
Station.create(location: "Railroad", team: empty)
Station.create(location: "Emil's place", team: empty)