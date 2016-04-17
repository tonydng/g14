class Book < ActiveRecord::Base
	
  validates :book_title, presence: true
end
