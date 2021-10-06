class User < ApplicationRecord
	has_many :posts
	validates :email,presence:true,uniqueness: true
	# validates :pass,presence:true
	has_secure_password

end
