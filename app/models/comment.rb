class Comment < ApplicationRecord
	belongs_to :post
	belongs_to :user
	validates :rating, presence: true
  validates :content, presence: true
end
