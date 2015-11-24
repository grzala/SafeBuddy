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

User.create!(:name => "admin", :password => "adminadmin", :email => "a@dmin.com", :moderator => true, :region_id => 3)


time = LastUpdated.new(:time => 0)
time.save

puts "Scraping articles, this might take a while. Please do not interrupt the process"
News.scrape

Comment.create!(:date => Time.now, :user_id => 1, :region_id => 1, :message => "just searching for crimes")
Comment.create!(:date => Time.now, :user_id => 2, :region_id => 2, :message => "I love crimes. Also i am a racist and a redneck")
Comment.create!(:date => Time.now, :user_id => 3, :region_id => 3, :message => "Hi i wanted to let you know that your page on crimes totally blows, I can make a similar one in, like, 5 minutes or whatever")


