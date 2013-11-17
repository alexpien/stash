class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	before_save { self.email = email.downcase }
	has_secure_password  

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

validates :name,  presence: true
validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
validates :password,  presence: true

end
