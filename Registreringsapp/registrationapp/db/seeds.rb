# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User with two keys
user1 = User.create(email: "test@test.se", password: "test")
ApiKey.create(api_key: SecureRandom.hex, user_id: user1.id)
ApiKey.create(api_key: SecureRandom.hex, user_id: user1.id)

# User with one key
user2 = User.create(email: "test2@test.se", password: "test")
ApiKey.create(api_key: SecureRandom.hex, user_id: user2.id)

# User without key
User.create(email: "test3@test.se", password: "test")

# Admin/superuser
User.create(email: "christoffer.goude@gmail.com", password: "admin")


