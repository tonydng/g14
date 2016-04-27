class Author < ActiveRecord::Base
	has_many :book_authors, dependent: :destroy
	has_many :books, through: :book_authors
	
	validates :author_name, presence: true
end
