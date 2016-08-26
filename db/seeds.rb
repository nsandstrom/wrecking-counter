# ruby encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Team.create(name: "Chaos", short_name: "666", colour: "FF0000")
Team.create(name: "Cyberkomm", short_name: "CYB", colour: "003CFF")
Team.create(name: "Klustret", short_name: "CLU", colour: "B300FF")
Team.create(name: "Hjortkloe", short_name: "HKM", colour: "FFBF00")


Station.create(location: "Vägslut", team: nil)
Station.create(location: "Sandfält", team: nil)
Station.create(location: "Skogsby", team: nil)
Station.create(location: "Grusdump", team: nil)