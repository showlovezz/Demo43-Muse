class Post < ApplicationRecord
	validates :title, length: {minimum: 5}
	validates :link, presence: true
	validates :description, presence: true
	validates :rating, presence: true
	belongs_to :user
end
