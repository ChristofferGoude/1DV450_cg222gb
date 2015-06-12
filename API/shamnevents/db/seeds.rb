# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Creator.delete_all
creator1 = Creator.create(name: "Klas Testsson", password: "klaspass")
creator2 = Creator.create(name: "Glenn Danzig", password: "superpassword")
creator3 = Creator.create(name: "Mr. T", password: "ipitythepassword")

Tag.delete_all
tag1 = Tag.create(name: "Test Tag")
tag2 = Tag.create(name: "Best Tag")
tag3 = Tag.create(name: "Next Tag")

Event.delete_all
Event.create(creator_id: creator1.id, name: "Concert", latitude: 61.3055762, longitude: 17.0628102, tags: [tag1])
Event.create(creator_id: creator2.id, name: "Theater show", latitude: 61.7273909, longitude: 17.10740099, tags: [tag1, tag2, tag3])
Event.create(creator_id: creator3.id, name: "Car race", latitude: 57.70887, longitude: 11.974559999, tags: [tag2, tag3])