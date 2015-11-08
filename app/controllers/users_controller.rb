class UsersController < ApplicationController
	protect_from_forgery except: :new
	def register
	end
	
	def new
		@user = User.new
		@user.name = params[:register_username]
		@user.password = params[:register_password]
		@user.email = params[:register_email]
		@user.save
		redirect_to root_path
	end
end
