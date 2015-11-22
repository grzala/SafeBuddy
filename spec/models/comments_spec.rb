require 'rails_helper'

describe Comment, 'methods' do

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

end
