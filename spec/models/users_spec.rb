require 'rails_helper'

describe User, 'methods' do
  it "can create user" do
	username = "puser"
	pass = "useruser"
	mail = "user@user.com"
  
	user = User.new
	user.name = username
	user.password = pass
	user.email = mail
	user.save
	
	user2 = User.find(user.id)
	puts user2.name
	expect(user2).to be
	expect(user2.name).to eq(username)
	expect(user2.email).to eq(mail)
	expect(user2.hash_password).not_to eq(pass)
	expect(user2.salt).to be
	
	expect(User.authenticate(username, pass)).to be
  end
  
  it "fails on too short password" do
	username = "puser"
	pass = "lal"
	mail = "user@user.com"
  
	user = User.new
	user.name = username
	user.password = pass
	user.email = mail
	expect(user.save).not_to be
  end
  
  it "fails on wrong emal" do
	username = "puser"
	pass = "useruser"
	mail = "deprdepr"
  
	user = User.new
	user.name = username
	user.password = pass
	user.email = mail
	expect(user.save).not_to be
  end
end
