class Book < ActiveRecord::Base
	has_many :book_authors, dependent: :destroy
	has_many :book_topics, dependent: :destroy
	has_many :authors, through: :book_authors
	has_many :topics, through: :book_topics
  validates :book_title, presence: true
end
