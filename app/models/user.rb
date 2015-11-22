class User < ActiveRecord::Base

	validates :name, :presence => true, :uniqueness => true, length: {maximum: 20}
	
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, :presence => true, format: { with: VALID_EMAIL_REGEX }, length: {maximum: 50}
	
	
	validates :password, :confirmation => true, length: {minimum: 6}
	attr_accessor :password_confirmation
	attr_reader :password
		
	def User.encrypt_password(password, salt)
		Digest::SHA2.hexdigest(password + "wibble" + salt)
	end
	
	
	def password=(password)
		@password = password
		
		if password.present?
			generate_salt
			self.hash_password = self.class.encrypt_password(password, salt)
		end
	end
	
	def User.authenticate(name, password)
		if user = find_by_name(name)
			if user.hash_password == encrypt_password(password, user.salt)
				user
			end
		end
	end
	
	def isMod
		return self.moderator
	end
	
	private
	
	def generate_salt
		self.salt = self.object_id.to_s + rand.to_s
	end	

end
