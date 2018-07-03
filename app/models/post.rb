class Post < ApplicationRecord
	validates :title, length: {minimum: 5}
	validates :link, presence: true
	validates :description, presence: true
	validates :rating, presence: true
	validates :image, presence: true
	belongs_to :user
	mount_uploader :image, PhotoUploader
end
