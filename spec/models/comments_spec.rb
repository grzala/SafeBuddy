require 'rails_helper'

describe Comment, 'methods' do

  before(:all) do
	`sunspot-solr start`
	begin
		Sunspot.remove_all!
	rescue Errno::ECONNREFUSED
		puts "sunspot setting up"
		sleep 1 && retry
	end
	
	usernames = ["rspec", "rpsec2", "rspec3"]
	usernames.each do |username|
		user = User.new
		user.name = username
		user.password = "testtest"
		user.email = "lala@lala.lala"
		user.save
	end
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
	comment.message = messaeg
	expect(comment.save).not_to be
  end
  
  it "authentidate comments" do
	comment = Comment.create!(:date => Time.now, :user_id => 1, :region_id => 1, :message => "lalala")
	
	expect(comment.allowedToEdit(2)).not_to be
	expect(comment.allowedToEdit(1)).to be
  end
  
end
