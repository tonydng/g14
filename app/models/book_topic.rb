class BookTopic < ActiveRecord::Base
  belongs_to :book
  belongs_to :topic
  validates :book_id, presence: true
  validates :topic_id, presence: true
end
