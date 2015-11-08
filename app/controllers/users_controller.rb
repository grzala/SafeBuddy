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
	
	def get_all
		respond_to do |format|
			format.js {
				@users = User.all
				render json: {:users => @users}
			}
		end
	end
end
