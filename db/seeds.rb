User.create!(:name => "test", :password => "testtest", :email => "test@test.com", :region_id => 2)
User.create!(:name => "test2", :password => "test2test2", :email => "test2@test2.com", :region_id => 3)
User.create!(:name => "admin", :password => "adminadmin", :email => "a@dmin.com", :moderator => true, :region_id => 3)

time = LastUpdated.new(:time => 0)
time.save

puts "Scraping articles, this might take a while. Please do not interrupt the process"
News.scrape

Comment.create!(:date => Time.now, :user_id => 1, :region_id => 1, :message => "just searching for crimes")
Comment.create!(:date => Time.now, :user_id => 2, :region_id => 2, :message => "my mother was a wood processor in cheese factory in auckland, france")
Comment.create!(:date => Time.now, :user_id => 3, :region_id => 3, :message => "I'm a lumber jack and I'm ok, I sleep all night and I work all day")


5.times do 
   Comment.create!(:date => Time.now, :user_id => 1, :region_id => 1, :message => "a lot of comments here") 
end