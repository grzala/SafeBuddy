class UsersController < ApplicationController
	protect_from_forgery except: :new
	protect_from_forgery except: :delete
	before_action :authorize, :only => [:list, :delete]
	
	def register
		@regions = Region.all
	end
	
	def delete
		user_id = params[:user_id]
		if user = User.find(user_id)
			user.destroy
		end
		redirect_to '/users/list'
	end
	
	def new
		@user = User.new
		@user.name = params[:register_username]
		@user.password = params[:register_password]
		@user.email = params[:register_email]
		@user.region_id = params[:register_region]
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
	
	def list
		@users = User.all
	end
	
	private
	
	def authorize
		user_id = session[:user_id]
		if !user_id.nil? && User.find(user_id).isMod
			return
		end
		redirect_to root_url
	end
end
