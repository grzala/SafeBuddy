# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

usr = User.new
usr.name = "test"
usr.password = "testtest"
usr.email = "test@test.com"
usr.region_id = 2
usr.save

usr = User.new
usr.name = "test2"
usr.password = "test2test2"
usr.email = "test2@test2.com"
usr.region_id = 3
usr.save
