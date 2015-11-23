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

usr = User.new(:name => "admin", :password => "adminadmin", :email => "a@dmin.com", :moderator => true, :region_id => 3)
usr.save

puts "Scraping atricles, this might take a while. Please do not interrupt the process"
News.scrape
