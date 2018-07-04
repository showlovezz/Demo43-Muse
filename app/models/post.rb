class Post < ApplicationRecord
	validates :title, length: {minimum: 5}
	validates :link, presence: true
	validates :description, presence: true
	validates :rating, presence: true
	validates :image, presence: true
	mount_uploader :image, PhotoUploader
	acts_as_votable
	belongs_to :user
	has_many :comments, dependent: :destroy
end
