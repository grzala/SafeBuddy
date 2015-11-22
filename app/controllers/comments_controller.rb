class CommentsController < ApplicationController
	def create
		respond_to do |format|
			format.js {
				@comment = Comment.new 
				@comment.user_id = params[:user_id]
				@comment.region_id = params[:region_id]
				@comment.date = Time.now
				@comment.message = params[:message]
				@comment.save
			
				@returnJson = {
                        :id => @comment.id,
                        :message => @comment.message,
                        :username => User.find(@comment.user_id).name,
                        :date => @comment.date
                    }
				render json: @returnJson
			}
			
		end	
	end
end
