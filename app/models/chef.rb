class Chef < ActiveRecord::Base
	has_many :recipes
	has_many :likes
	before_save {self.email =  email.downcase}
	validates :chef_name, presence: true, length: {minimum: 4, maximum: 40}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 105}, uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX}
	has_secure_password

	mount_uploader :picture, PictureUploader
	validate :picture_chef_size

	private
		def picture_chef_size
			if picture.size > 2.megabytes
				errors.add(:picture, "Should be less than 5MB")
			end
		end
end
