require 'rails_helper'

describe Comment, 'methods' do

  before(:all) do
	usernames = ["rspec", "rpsec2", "rspec3"]
	usernames.each do |username|
		user = User.new
		user.name = username
		user.password = "testtest"
		user.email = "lala@lala.lala"
		user.save
		
		$com = []
		$com.push Comment.create!(:date => Time.now, :user_id => 1, :region_id => 1, :message => "just searching for crimes")
		$com.push Comment.create!(:date => Time.now, :user_id => 2, :region_id => 2, :message => "I love crimes. Also i am a racist and a redneck")
		$com.push Comment.create!(:date => Time.now, :user_id => 3, :region_id => 3, :message => "Hi i wanted to let you know that your page on crimes totally blows, I can make a similar one in, like, 5 minutes or whatever")
		
	end
  end

  
  it "can create comment" do
	
	message = "testtest"
	
	comment = Comment.new
	comment.date = Time.now
	comment.user_id = 1
	comment.region_id = 1
	comment.message = message
	expect(comment.save).to be
  end

  it "fails on too long message" do
	
	message = ""
	
	500.times do
		message += "a"
	end
	
	comment = Comment.new
	comment.date = Time.now
	comment.user_id = 1
	comment.region_id = 1
	comment.message = message
	expect(comment.save).not_to be
  end
  
  it "authentidate comments" do
	comment = Comment.new
	comment.date = Time.now
	comment.user_id = 1
	comment.region_id = 1
	comment.message = "lalala"
	comment.save
	
	expect(comment.allowedToEdit(2)).not_to be
	expect(comment.allowedToEdit(1)).to be
  end
  
  it "can search through comments" do
	
	results = Comment.search("crime")
	
	expect(results).to be_an(Array)
	expect(results).to match_array($com)
	expect(results.length).to eq(3)
  end

end
