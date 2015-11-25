class NewsController < ApplicationController
    
	protect_from_forgery except: :delete
    
    def list
        @articles = News.all
    end
    
    def delete
        @article = News.find(params[:article_id])
        if @article
            @article.destroy
        end
        redirect_to '/news/list'
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
