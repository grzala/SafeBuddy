class SessionsController < ApplicationController

	def create
		respond_to do |format|
		 format.js {
			
			@username = params[:username]
			@password = params[:password]
			if @usr = User.authenticate(@username, @password)
				session[:user_id] = @usr.id
				render json: {:isAuthenticated => true}
			else
				render json: {:isAuthenticated => false}
			end
		 }
		end
	end
	
	def destroy
		session[:user_id] = nil
		redirect_to root_url
	end
end
