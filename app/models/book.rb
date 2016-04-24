class Book < ActiveRecord::Base
  belongs_to :publisher
  belongs_to :topic
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  
  # a book must have a publisher and a topic
  validates :publisher_id, :topic_id, presence: true
  # a book must have a book name
  validates :book_name, presence: true
end
