class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :region
	
	validates :message, length: {maximum: 300}
	
	def allowedToEdit(id)
		return false if !id
		
		@user = User.find(id)
		
		if @user.isMod || @user.id == self.user_id
			return true
		end
		
		return false
	end
	
	def self.search(search)
		results = []
		
		#perform search
		
		return results	
	end
end
