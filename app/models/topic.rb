class Topic < ActiveRecord::Base
	has_many :book_topics, dependent: :destroy
	has_many :books, through: :book_topics
	validates :topic_name, presence: true
end
