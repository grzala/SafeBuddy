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
		
		#find by message
		Comment.where('message LIKE ?', '%' + search + '%').each do |comment|
			results.push comment
		end
		
		#find by users
		if user = User.find_by_name(search)
			Comment.where(:user_id => user.id).each do |comment|
				results.push comment
			end
		end
		
		#region
		Region.where('name LIKE ?', '%' + search + '%').each do |region|
			Comment.where(:region_id => region.id).each do |comment|
				results.push comment
			end
		end
		
		#double entry check
		new_results = []
		results.each do |r|
			new_results.push r unless new_results.include?(r)
		end
		results = new_results
		
		return nil if results.length == 0
		
		return results
	end
end
