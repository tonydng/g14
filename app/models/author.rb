class Author < ActiveRecord::Base
	has_many :book_authors, dependent: :destroy
	validates :author_name, presence: true
end
